#!/usr/bin/env ruby
#
# Check Procs
# ===
#
# Finds processes matching various filters (name, state, etc). Will not
# match itself by default. The number of processes found will be tested
# against the Warning/critical thresholds. By default, fails with a
# CRITICAL if more than one process matches -- you must specify values
# for -w and -c to override this.
#
# Attempts to work on Cygwin (where ps does not have the features we
# need) by calling Windows' tasklist.exe, but this is not well tested.
#
# Examples:
#
#   # chef-client is running
#   check-procs -p chef-client -W 1
#
#   # there are not too many zombies
#   check-procs -s Z -w 5 -c 10
#
# Copyright 2011 Sonian, Inc <chefs@sonian.net>
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-plugin/check/cli'

class CheckProcs < Sensu::Plugin::Check::CLI

  def self.read_pid(path)
    begin
      File.read(path).chomp.to_i
    rescue
      self.new.unknown "Could not read pid file #{path}"
    end
  end

  option :warn_over,
    :short => '-w N',
    :long => '--warn-over N',
    :description => 'Trigger a warning if over a number',
    :proc => proc {|a| a.to_i }

  option :crit_over,
    :short => '-c N',
    :long => '--critical-over N',
    :description => 'Trigger a critical if over a number',
    :proc => proc {|a| a.to_i }

  option :warn_under,
    :short => '-W N',
    :long => '--warn-under N',
    :description => 'Trigger a warning if under a number',
    :proc => proc {|a| a.to_i },
    :default => 1

  option :crit_under,
    :short => '-C N',
    :long => '--critical-under N',
    :description => 'Trigger a critial if under a number',
    :proc => proc {|a| a.to_i },
    :default => 1

  option :metric,
    :short => '-t METRIC',
    :long => '--metric METRIC',
    :description => 'Trigger a critical if there are METRIC procs',
    :proc => proc {|a| a.to_sym }

  option :match_self,
    :short => '-m',
    :long => '--match-self',
    :description => 'Match itself',
    :boolean => true,
    :default => false

  option :match_parent,
    :short => '-M',
    :long => '--match-parent',
    :description => 'Match parent process it uses ruby {process.ppid}',
    :boolean => true,
    :default => false

  option :cmd_pat,
    :short => '-p PATTERN',
    :long => '--pattern PATTERN',
    :description => 'Match a command against this pattern'

  option :file_pid,
    :short => '-f PID',
    :long => '--file-pid PID',
    :description => 'Check against a specific PID',
    :proc => proc {|a| read_pid(a) }

  option :vsz,
    :short => '-z VSZ',
    :long => '--virtual-memory-size VSZ',
    :description => 'Trigger on a Virtual Memory size is bigger than this',
    :proc => proc {|a| a.to_i }

  option :rss,
    :short => '-r RSS',
    :long => '--resident-set-size RSS',
    :description => 'Trigger on a Resident Set size is bigger than this',
    :proc => proc {|a| a.to_i }

  option :pcpu,
    :short => '-P PCPU',
    :long => '--proportional-set-size PCPU',
    :description => 'Trigger on a Proportional Set Size is bigger than this',
    :proc => proc {|a| a.to_f }

  option :state,
    :short => '-s STATE',
    :long => '--state STATE',
    :description => 'Trigger on a specific state, example: Z for zombie',
    :proc => proc {|a| a.split(',') }

  option :user,
    :short => '-u USER',
    :long => '--user USER',
    :description => 'Trigger on a specific user',
    :proc => proc {|a| a.split(',') }

  option :esec_over,
    :short => '-e SECONDS',
    :long => '--esec-over SECONDS',
    :proc => proc {|a| a.to_i },
    :description => 'Match processes that older that this, in SECONDS'

  option :esec_under,
    :short => '-E SECONDS',
    :long => '--esec-under SECONDS',
    :proc => proc {|a| a.to_i },
    :description => 'Match process that are younger than this, in SECONDS'

  def read_lines(cmd)
    IO.popen(cmd + ' 2>&1') do |child|
      child.read.split("\n")
    end
  end

  def line_to_hash(line, *cols)
    Hash[cols.zip(line.strip.split(/\s+/, cols.size))]
  end

  def on_cygwin?
    `ps -W 2>&1`; $?.exitstatus == 0
  end

  def get_procs
    if on_cygwin?
      read_lines('ps -aWl').drop(1).map do |line|
        # Horrible hack because cygwin's ps has no o option, every
        # format includes the STIME column (which may contain spaces),
        # and the process state (which isn't actually a column) can be
        # blank. As of revision 1.35, the format is:
        # const char *lfmt = "%c %7d %7d %7d %10u %4s %4u %8s %s\n";
        state = line.slice!(0..0)
        _stime = line.slice!(45..53)
        line_to_hash(line, :pid, :ppid, :pgid, :winpid, :tty, :uid, :etime, :command).merge(:state => state)
      end
    else
      read_lines('ps axwwo user,pid,vsz,rss,pcpu,state,etime,command').drop(1).map do |line|
        line_to_hash(line, :user, :pid, :vsz, :rss, :pcpu, :state, :etime, :command)
      end
    end
  end

  def etime_to_esec(etime)
    m = /(\d+-)?(\d\d:)?(\d\d):(\d\d)/.match(etime)
    (m[1]||0).to_i*86400 + (m[2]||0).to_i*3600 + (m[3]||0).to_i*60 + (m[4]||0).to_i
  end

  def run
    procs = get_procs

    procs.reject! {|p| p[:pid].to_i != config[:file_pid] } if config[:file_pid]
    procs.reject! {|p| p[:pid].to_i == $$ } unless config[:match_self]
    procs.reject! {|p| p[:pid].to_i == Process.ppid } unless config[:match_parent]
    procs.reject! {|p| p[:command] !~ /#{config[:cmd_pat]}/ } if config[:cmd_pat]
    procs.reject! {|p| p[:vsz].to_f < config[:vsz] } if config[:vsz]
    procs.reject! {|p| p[:rss].to_f < config[:rss] } if config[:rss]
    procs.reject! {|p| p[:pcpu].to_f < config[:pcpu] } if config[:pcpu]
    procs.reject! {|p| etime_to_esec(p[:etime]) >= config[:esec_under] } if config[:esec_under]
    procs.reject! {|p| etime_to_esec(p[:etime]) <= config[:esec_over] } if config[:esec_over]
    procs.reject! {|p| !config[:state].include?(p[:state]) } if config[:state]
    procs.reject! {|p| !config[:user].include?(p[:user]) } if config[:user]

    msg = "Found #{procs.size} matching processes"
    msg += "; cmd /#{config[:cmd_pat]}/" if config[:cmd_pat]
    msg += "; state #{config[:state].join(',')}" if config[:state]
    msg += "; user #{config[:user].join(',')}" if config[:user]
    msg += "; vsz > #{config[:vsz]}" if config[:vsz]
    msg += "; rss > #{config[:rss]}" if config[:rss]
    msg += "; pcpu > #{config[:pcpu]}" if config[:pcpu]
    msg += "; esec < #{config[:esec_under]}" if config[:esec_under]
    msg += "; esec > #{config[:esec_over]}" if config[:esec_over]
    msg += "; pid #{config[:file_pid]}" if config[:file_pid]

    if config[:metric]
      count = procs.map {|p| p[config[:metric]].to_i }.reduce {|a, b| a + b }
      msg += "; #{config[:metric]} == #{count}"
    else
      count = procs.size
    end

    if !!config[:crit_under] && count < config[:crit_under]
      critical msg
    elsif !!config[:crit_over] && count > config[:crit_over]
      critical msg
    elsif !!config[:warn_under] && count < config[:warn_under]
      warning msg
    elsif !!config[:warn_over] && count > config[:warn_over]
      warning msg
    else
      ok msg
    end
  end

end

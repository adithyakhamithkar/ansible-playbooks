#!/usr/bin/env ruby
#
# Check Disk Plugin
# ===
#
# Uses GNU's -T option for listing filesystem type; unfortunately, this
# is not portable to BSD. Warning/critical levels are percentages only.
#
# Copyright 2011 Sonian, Inc <chefs@sonian.net>
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-plugin/check/cli'

class CheckDisk < Sensu::Plugin::Check::CLI

  option :fstype,
    :short => '-t TYPE',
    :proc => proc {|a| a.split(',') }

  option :ignoretype,
    :short => '-x TYPE',
    :proc => proc {|a| a.split(',') }

  option :ignoremnt,
    :short => '-i MNT',
    :proc => proc {|a| a.split(',') }

  option :ignoreline,
    :short => '-l PATTERN[,PATTERN]',
    :description => 'Ignore df line(s) matching pattern(s)',
    :proc => proc { |a| a.split(',') }

  option :includeline,
    :short => '-L PATTERN[,PATTERN]',
    :description => 'Only include df line(s) matching pattern(s)',
    :proc => proc { |a| a.split(',') }

  option :warn,
    :short => '-w PERCENT',
    :proc => proc {|a| a.to_i },
    :default => 85

  option :crit,
    :short => '-c PERCENT',
    :proc => proc {|a| a.to_i },
    :default => 95

  option :debug,
      :short => '-d',
      :long => '--debug',
      :description => 'Output list of included filesystems'

  def initialize
    super
    @crit_fs = []
    @warn_fs = []
    @line_count = 0
  end

  def read_df
    `df -PT`.split("\n").drop(1).each do |line|
      begin
        _fs, type, _blocks, _used, _avail, capacity, mnt = line.split
        next if config[:includeline] && !config[:includeline].find { |x| line.match(x) }
        next if config[:fstype] && !config[:fstype].include?(type)
        next if config[:ignoretype] && config[:ignoretype].include?(type)
        next if config[:ignoremnt] && config[:ignoremnt].include?(mnt)
        next if config[:ignoreline] && config[:ignoreline].find { |x| line.match(x) }
        puts line if config[:debug]
      rescue
        unknown "malformed line from df: #{line}"
      end
      @line_count += 1
      if capacity.to_i >= config[:crit]
        @crit_fs << "#{mnt} #{capacity}"
      elsif capacity.to_i >= config[:warn]
        @warn_fs <<  "#{mnt} #{capacity}"
      end
    end
  end

  def usage_summary
    (@crit_fs + @warn_fs).join(', ')
  end

  def run
    if config[:includeline] && config[:ignoreline]
      unknown 'Do not use -l and -L options concurrently'
    end
    read_df
    unknown 'No filesystems found' unless @line_count > 0
    critical usage_summary unless @crit_fs.empty?
    warning usage_summary unless @warn_fs.empty?
    ok "All disk usage under #{config[:warn]}%"
  end

end

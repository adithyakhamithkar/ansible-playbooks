#!/usr/bin/env ruby
#
# Sensu Handler: mailer
#
# This handler formats alerts as mails and sends them off to a pre-defined recipient.
#
# Copyright 2012 Pal-Kristian Hamre (https://github.com/pkhamre | http://twitter.com/pkhamre)
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

# Note: The default mailer config is fetched from the predefined json config file which is "mailer.json" or any other
#       file defiend using the "json_config" command line option. The mailing list could also be configured on a per client basis
#       by defining the "mail_to" attribute in the client config file. This will override the default mailing list where the
#       alerts are being routed to for that particular client.

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-handler'
require 'mail'
require 'timeout'

# patch to fix Exim delivery_method: https://github.com/mikel/mail/pull/546
# #YELLOW
module ::Mail # rubocop:disable Style/ClassAndModuleChildren
  class Exim < Sendmail
    def self.call(path, arguments, _destinations, encoded_message)
      popen "#{path} #{arguments}" do |io|
        io.puts encoded_message.to_lf
        io.flush
      end
    end
  end
end

class Mailer < Sensu::Handler
  option :json_config,
         description: 'Config Name',
         short: '-j JsonConfig',
         long: '--json_config JsonConfig',
         required: false

  def short_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def action_to_string
    @event['action'].eql?('resolve') ? 'RESOLVED' : 'ALERT'
  end

  def status_to_string
    case @event['check']['status']
    when 0
      'OK'
    when 1
      'WARNING'
    when 2
      'CRITICAL'
    else
      'UNKNOWN'
    end
  end

  def build_mail_to_list
    json_config = config[:json_config] || 'mailer'
    mail_to = @event['client']['mail_to'] || settings[json_config]['mail_to']
    if settings[json_config].key?('subscriptions')
      @event['check']['subscribers'].each do |sub|
        if settings[json_config]['subscriptions'].key?(sub)
          mail_to << ", #{settings[json_config]['subscriptions'][sub]['mail_to']}"
        end
      end
    end
    mail_to
  end

  def handle
    json_config = config[:json_config] || 'mailer'
    admin_gui = settings[json_config]['admin_gui'] || 'http://localhost:8080/'
    mail_to = build_mail_to_list
    mail_from =  settings[json_config]['mail_from']
    reply_to = settings[json_config]['reply_to'] || mail_from

    delivery_method = settings[json_config]['delivery_method'] || 'smtp'
    smtp_address = settings[json_config]['smtp_address'] || 'localhost'
    smtp_port = settings[json_config]['smtp_port'] || '25'
    smtp_domain = settings[json_config]['smtp_domain'] || 'localhost.localdomain'

    smtp_username = settings[json_config]['smtp_username'] || nil
    smtp_password = settings[json_config]['smtp_password'] || nil
    smtp_authentication = settings[json_config]['smtp_authentication'] || :plain
    smtp_enable_starttls_auto = settings[json_config]['smtp_enable_starttls_auto'] == 'false' ? false : true

    playbook = "Playbook:  #{@event['check']['playbook']}" if @event['check']['playbook']
    body = <<-BODY.gsub(/^\s+/, '')
            #{@event['check']['output']}
            Admin GUI: #{admin_gui}
            Host: #{@event['client']['name']}
            Timestamp: #{Time.at(@event['check']['issued'])}
            Address:  #{@event['client']['address']}
            Check Name:  #{@event['check']['name']}
            Command:  #{@event['check']['command']}
            Status:  #{status_to_string}
            Occurrences:  #{@event['occurrences']}
            #{playbook}
          BODY
    if @event['check']['notification'].nil?
      subject = "#{action_to_string} - #{short_name}: #{status_to_string}"
    else
      subject = "#{action_to_string} - #{short_name}: #{@event['check']['notification']}"
    end

    Mail.defaults do
      delivery_options = {
        address: smtp_address,
        port: smtp_port,
        domain: smtp_domain,
        openssl_verify_mode: 'none',
        enable_starttls_auto: smtp_enable_starttls_auto
      }

      unless smtp_username.nil?
        auth_options = {
          user_name: smtp_username,
          password: smtp_password,
          authentication: smtp_authentication
        }
        delivery_options.merge! auth_options
      end

      delivery_method delivery_method.intern, delivery_options
    end

    begin
      timeout 10 do
        Mail.deliver do
          to mail_to
          from mail_from
          reply_to reply_to
          subject subject
          body body
        end

        puts 'mail -- sent alert for ' + short_name + ' to ' + mail_to.to_s
      end
    rescue Timeout::Error
      puts 'mail -- timed out while attempting to ' + @event['action'] + ' an incident -- ' + short_name
    end
  end
end

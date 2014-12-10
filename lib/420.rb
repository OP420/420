require 'rubygems'
require 'bundler/setup'

require "thor"
require "time_diff"
require 'i18n'


class App < Thor
    desc "time", "Gets the time left until the next 4:20"
    def time(time=Time.new)
        if time.is_a? String
            time = Time.parse(time)
        end
        return FourTwenty.timeUntil420(time)
    end
    default_task :time
end


# FourTwenty is the includable ruby module to run the thor app and test
module FourTwenty
    def self.timeUntil420(time=Time.new)
        # This truncates the seconds off the time, to prevent rounding
        time = Time.parse(time.strftime("%H:%M:00"), time)
        time = Time.local(time.year, time.month, time.day, time.strftime("%I"), time.strftime("%M"))

        bowl_times = [Time.local(time.year, time.month, time.day, 4, 20),
            Time.local(time.year, time.month, time.day, 16, 20)]

        # This means it's exactly 420!
        if time.strftime("%I:%M") == "04:20"
            local = I18n.t :happy, :scope => 'returns'
            return local

        # This means it's before 4:20am.
        elsif time < bowl_times[0]
            time_until = Time.diff(time, bowl_times[0])
        # This means it's passed 4:20am.
        elsif time > bowl_times[0] and time < bowl_times[1]
            time_until = Time.diff(time, bowl_times[1])
        end

        # It's minutes until 420
        if time_until[:hour] == 0
            local = I18n.t :time_minutes, :scope => 'returns'
            return local % [time_until[:minute]]
        # It's hours until 420
        else
            local = I18n.t :time, :scope => 'returns'
            return local % [time_until[:hour], time_until[:minute]]
        end
    end

    def self.run
        dir = File.dirname(__FILE__)
        I18n.load_path = Dir[dir + '/local/*.yml', dir + '/local/*.rb']
        puts App.start
    end
    def self.run_from_time(args)
        dir = File.dirname(__FILE__)
        I18n.load_path = Dir[dir + '/local/*.yml', dir + '/local/*.rb']
        I18n.enforce_available_locales = false
        App.start(args)
    end
end

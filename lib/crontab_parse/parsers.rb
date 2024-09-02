require "singleton"
require "crontab_parse/part_parser"
require "crontab_parse/minute_parser"
require "crontab_parse/hour_parser"
require "crontab_parse/day_of_month_parser"
require "crontab_parse/month_parser"
require "crontab_parse/day_parser"
require "crontab_parse/parser_error"
require "debug"

module CrontabParse
  class Parsers
    include Singleton

    class << self
      def parse_minute(expression)
        instance.minute.parse(expression)
      end

      def parse_hour(expression)
        instance.hour.parse(expression)
      end

      def parse_day_of_month(expression)
        instance.day_of_month.parse(expression)
      end

      def parse_month(expression)
        return instance.month.parse(expression)
      end

      def parse_day(expression)
        instance.day.parse(expression)
      end
    end

    def minute
      @minute ||= MinuteParser.new
    end

    def hour
      @hour ||= HourParser.new
    end

    def day_of_month
      @day_of_month ||= DayOfMonthParser.new
    end

    def month
      @month ||= MonthParser.new
    end

    def day
      @day ||= DayParser.new
    end
  end
end

require "singleton"
require "crontab_parse/part_parser"
require "crontab_parse/minute_parser"
require "crontab_parse/hour_parser"
require "crontab_parse/parser_error"
require "debug"

module CrontabParse
  class Parsers
    include Singleton

    class << self
      def parse_minutes(expression)
        instance.minute.parse(expression)
      end

      def parse_hours(expression)
        instance.hour.parse(expression)
      end


      def parse_day_of_month(expression)
        instance.day_of_month.parse(expression)
        # if instance.day_of_month.valid?(expression)

        # raise ParserError, "Invalid day of month value: [#{expression}]. Valid day of month values are integers between 1 and 31."
      end

      def parse_month(expression)
        return instance.month.parse(expression) if instance.month.valid?(expression)

        raise ParserError,
              "Invalid day of month value: [#{expression}]. Valid month values are integers between 1 and 12."
      end
    end

    def minute
      @minute ||= Parser::MinuteParser.new
      # validation_regexp: %r{^([0-5]?\d|\*(?:/[0-5]?\d)?)|(?:(?:[0-5]?\d)-(?:[0-5]?\d))$},
      # range_regexp: %r{(?:(?<lower_bound>[0-5]?\d)-(?<upper_bound>[0-5]?\d))},
      # valid_range: (0..59)
    end

    def hour
      @hour ||= Parser::HourParser.new
      # validation_regexp: %r{^(?:[01]?\d|2[0-3]|\*(?<step>(?:/[01]?\d)|2[0-3])?)|(?:([01]?\d|2[0-3])-(?:[01]?\d|2[0-3]))$},
      # stepped_regexp: %r{^\*/(?<step>(?:[01]?\d)|2[0-3])$},
      # range_regexp: %r{^([01]?\d|2[0-3])-([01]?\d|2[0-3])$},
      # valid_range: (0..23)
    end

    def day_of_month
      @day_of_month ||= PartParser.new(
        validation_regexp: %r{^(0[1-9]|[12]?[1-9]|[12]0|3[01]|\*(?:/([1-9]|[12][0-9]|[3[01]]))?)$},
        stepped_regexp: %r{^\*/(?<step>(?:[01]?\d)|2[0-3])$},
        range_regexp: /(?:(?<lower_bound>[0-5]?\d)-(?<upper_bound>[0-5]?\d))/,
        valid_range: (1..31)
      )
    end

    def month
      @month ||= PartParser.new(
        validation_regexp: %r{^(0?[1-9]|1[012]|(?:#{PartParser::VALID_MONTH_STRINGS.join("|")})|\*(?:/([1-9]|1[0-2]))?)$}i,
        stepped_regexp: %r{^\*/(?<step>[1-9]|1[0-2])$},
        range_regexp: /(?:(?<lower_bound>[0-5]?\d)-(?<upper_bound>[0-5]?\d))/,
        valid_range: (1..12)
      )
    end
  end
end

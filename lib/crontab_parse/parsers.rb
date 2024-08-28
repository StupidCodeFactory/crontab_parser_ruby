require "singleton"
require "crontab_parse/part_parser"
require "crontab_parse/parser_error"

module CrontabParse
  class Parsers
    include Singleton

    class << self
      def parse_minutes(expression)
        return instance.minutes.parse(expression) if instance.minutes.valid?(expression)

        raise ParserError, "Invalid minute value: [#{expression}]. Valid minute values are integers between 0 and 59."
      end

      def parse_hours(expression)
        return instance.hours.parse(expression) if instance.hours.valid?(expression)

        raise ParserError, "Invalid hour value: [#{expression}]. Valid hour values are integers between 0 and 23."
      end
    end

    def minutes
      @minutes ||= PartParser.new(
        validation_regexp: %r{^([0-5]?\d|\*(?:/[0-5]?\d)?)$},
        stepped_regexp: %r{^\*/(?<step>[0-5]?\d)$},
        valid_range: (0..59)
      )
    end

    def hours
      @hours ||= PartParser.new(
        validation_regexp: %r{^(?:[01]?\d|2[0-3]|\*/(?<step>(?:[01]?\d)|2[0-3])?)$},
        stepped_regexp: %r{^\*/(?<step>(?:[01]?\d)|2[0-3])$},
        valid_range: (0..59)
      )
    end
  end
end

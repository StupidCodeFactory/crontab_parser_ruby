# frozen_string_literal: true

require "crontab_parse/part_parser"
require "crontab_parse/parser_error"

module CrontabParse
  class HourParser < PartParser
    WILDCARD = "*"

    STEPPED_REGEXP = %r{^\*/(?<step>([01]?\d)|2[0-3])$}

    def initialize(valid_range: (0..23))
      super
    end

    private

    attr_accessor :valid_range

    def error_message(expression)
      "Invalid hour value: [#{expression}]. Valid hour values are integers between 0 and 23."
    end

  end
end

# frozen_string_literal: true

require "crontab_parse/part_parser"
require "crontab_parse/parser_error"

module CrontabParse
  class MinuteParser < PartParser
    def initialize(valid_range: (0..59))
      super
    end

    def error_message(expression)
      "Invalid minute value: [#{expression}]. Valid minute values are integers between 0 and 59."
    end
  end
end

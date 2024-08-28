# frozen_string_literal: true

require_relative "crontab_parse/version"

module CrontabParse

  class Parser

    CRONTAB_PARTS_MINUTES_INDEX = 0

    def initialize(crontab_expression)
      self.crontab_expression = crontab_expression
    end

    def minutes
      [crontabs_parts[CRONTAB_PARTS_MINUTES_INDEX].to_i]
    end

    private
    attr_accessor :crontab_expression

    def crontabs_parts
      @crontabs_parts ||= crontab_expression.split(/\W/)
    end
  end

  class << self
    def parse(crontab_expression)
      parser = Parser.new(crontab_expression)
      {
        minutes: parser.minutes,
        hours: (0..23).to_a,
        day_of_month: (1..31).to_a,
        months: (1..12).to_a,
        day_of_week: (1..7).to_a
      }
    end
  end
end

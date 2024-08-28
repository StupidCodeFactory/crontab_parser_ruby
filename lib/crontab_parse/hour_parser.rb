# frozen_string_literal: true

require "crontab_parse/parser_error"

module CrontabParse
  class Parser
    class HourParser
      WILDCARD = "*"
      VALID_RANGE = (0..23)

      STEPPED_REGEXP = %r{^\*/(?<step>([01]?\d)|2[0-3])$}

      def initialize(expression)
        self.expression = expression
      end

      def parse
        raise ParserError, error_message unless valid?

        return VALID_RANGE.to_a if wildcard?

        return parse_stepped_expression if stepped?

        [expression.to_i]
      end

      private

      attr_accessor :expression

      def parse_stepped_expression
        step = expression.match(STEPPED_REGEXP)[:step].to_i
        VALID_RANGE.step(step).to_a
      end

      def stepped?
        expression.match?(STEPPED_REGEXP)
      end

      def wildcard?
        expression == WILDCARD
      end

      def valid?
        expression.match?(%r{^([01]?\d|2[0-3]|\*(/\d+)?)$})
      end

      def error_message
        "Invalid hour value: [#{expression}]. Valid hour values are integers between 0 and 23."
      end
    end
  end
end

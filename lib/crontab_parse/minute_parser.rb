# frozen_string_literal: true

require "crontab_parse/parser_error"

module CrontabParse
  class Parser
    class MinuteParser
      WILDCARD = "*"
      VALID_RANGE = (0..59).freeze

      STEPPED_REGEXP = %r{^\*(/(?<step>[0-5]?\d))$}

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

      def parse_stepped_expression(expression)
        step = expression.match(STEPPED_REGEXP)[:step].to_i
        VALID_RANGE.step(step).to_a
      end

      def stepped?(expression)
        expression.match?(STEPPED_REGEXP)
      end

      def wildcard?
        expression == WILDCARD
      end

      def valid?
        expression.match?(%r{^([0-5]?\d|\*(/[0-5]?\d))$})
      end

      def error_message
        "Invalid minute value: [#{expression}]. Valid minute values are integers between 0 and 59."
      end
    end
  end
end

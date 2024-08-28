
module CrontabParse
  class PartParser
    WILDCARD = "*"

    def initialize(validation_regexp:, stepped_regexp:, valid_range:)
      self.validation_regexp = validation_regexp
      self.stepped_regexp    = stepped_regexp
      self.valid_range       = valid_range
    end

    def parse(expression)
      raise ParserError unless valid?(expression)

      return valid_range.to_a if wildcard?(expression)

      return parse_stepped_expression(expression) if stepped?(expression)

      [expression.to_i]
    end

    def valid?(expression)
      expression.match?(validation_regexp)
    end

    private

    attr_accessor :validation_regexp, :stepped_regexp, :valid_range

    def parse_stepped_expression(expression)
      step = expression.match(stepped_regexp)[:step].to_i
      valid_range.step(step).to_a
    end

    def stepped?(expression)
      expression.match?(stepped_regexp)
    end

    def wildcard?(expression)
      expression == WILDCARD
    end
  end
end

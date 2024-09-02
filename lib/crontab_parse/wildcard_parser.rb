module CrontabParse
  class WildcardParser
    WILDCARD = "*".freeze

    def initialize(valid_range)
      self.valid_range = valid_range
    end

    def parse(expression)
      self.expression = expression
      valid?
    end

    def to_a
      valid_range.to_a
    end

    private

    attr_accessor :valid_range, :expression

    def valid?
      expression == WILDCARD
    end
  end
end

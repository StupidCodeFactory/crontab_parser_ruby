module CrontabParse
  class ListParser
    def initialize(valid_range)
      self.valid_range = valid_range
    end

    def parse(expression)
      self.list = expression.split(",")

      valid?
    end

    def to_a
      list.map(&:to_i)
    end

    private

    attr_accessor :valid_range, :list

    def valid?
      list.all? do |maybe_number|
        maybe_number.match?(/^\d+$/) && valid_range.include?(maybe_number.to_i)
      end
    end
  end
end

require "crontab_parse/parser_types/range_parser"
require "crontab_parse/parser_types/step_parser"
require "crontab_parse/parser_types/list_parser"
require "crontab_parse/parser_types/wildcard_parser"
require "crontab_parse/parser_types/digit_parser"

module CrontabParse
  class PartParser
    def initialize(
          valid_range: ,
          range_parser_class: RangeParser,
          step_parse_class: StepParser,
          wildcard_parser_class: WildcardParser,
          list_parser_class: ListParser,
          digit_parser_class: DigitParser)
      self.valid_range     = valid_range
      self.range_parser    = range_parser_class.new(valid_range)
      self.step_parser     = step_parse_class.new(valid_range)
      self.list_parser     = list_parser_class.new(valid_range)
      self.wildcard_parser = wildcard_parser_class.new(valid_range)
      self.digit_parser    = digit_parser_class.new(valid_range)
    end

    def parse(expression)
      return range_parser.to_a    if range_parser.parse(expression)
      return step_parser.to_a     if step_parser.parse(expression)
      return wildcard_parser.to_a if wildcard_parser.parse(expression)
      return list_parser.to_a     if list_parser.parse(expression)
      return digit_parser.to_a    if digit_parser.parse(expression)

      extra_parsers_result = yield if block_given?

      return extra_parsers_result if extra_parsers_result

      raise ParserError, error_message(expression)
    end

    private

    attr_accessor :valid_range, :range_parser, :step_parser, :list_parser, :wildcard_parser, :digit_parser
  end
end

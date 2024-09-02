require "spec_helper"
require "crontab_parse/month_parser"

RSpec.describe CrontabParse::MonthParser do
  describe "#parse" do
    context "when given a valid numerical month" do
      "1".upto("12") do |month|
        it "parses #{month}" do
          expect(subject.parse(month)).to eq([month.to_i])
        end
      end

      context "when given an invalid month" do
        it "raise an error " do
          expect {
            expect(subject.parse("13"))
          }.to raise_error(
                 CrontabParse::ParserError,
                 "Invalid month value: [13]. Valid month values are integers between 1 and 12."
               )
        end
      end

      context "when given with a leading 0" do
        "01".upto("12") do |month|
          it "parses #{month}" do
            expect(subject.parse(month)).to eq([month.to_i])
          end
        end
      end
    end
  end

  context "when given a range" do
    it "parses 2-12" do
      expect(subject.parse("2-12")).to eq((2..12).to_a)
    end

    context "when given an invalid range" do
      it "raise an error " do
        expect {
          expect(subject.parse("2-13"))
        }.to raise_error(
               CrontabParse::ParserError,
               "Invalid month value: [2-13]. Valid month values are integers between 1 and 12."
             )
      end
    end
  end

  context "with , separated values" do
    it "parses a list of day of month" do
      expect(subject.parse("4,6")).to eq([4, 6])
    end

    context "when list value contains an out of bound value" do
      it "parses raises an error" do
        expect do
          subject.parse("4,6,23")
        end.to raise_error(
                 CrontabParse::ParserError,
                 "Invalid month value: [4,6,23]. Valid month values are integers between 1 and 12."
               )
      end
    end
  end

  context "when give a stepped value" do
    it "parses */10" do
      expect(subject.parse("*/10")).to eq([1, 11])
    end

    context "when given and invalid stepped value" do
      it "raises an error" do
        expect {
          subject.parse("*/32")
        }.to raise_error(
               CrontabParse::ParserError,
               "Invalid month value: [*/32]. Valid month values are integers between 1 and 12."
             )
      end
    end
  end

  it "parses a wildcard" do
    expect(subject.parse("*")).to eq((1..12).to_a)
  end

  context "when give 3 letters month name" do
    %w[JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC].each_with_index do |month, index|
      it "parses #{month}" do
        expect(subject.parse(month)).to eq([index + 1])
      end
    end

    %w[jan feb mar apr may jun jul aug sep oct nov dec].each_with_index do |month, index|
      it "parses #{month}" do
        expect(subject.parse(month)).to eq([index + 1])
      end
    end
  end
end

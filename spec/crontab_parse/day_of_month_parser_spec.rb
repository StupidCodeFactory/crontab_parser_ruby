require 'spec_helper'
require "crontab_parse/day_of_month_parser"

RSpec.describe CrontabParse::DayOfMonthParser do
  describe "#parse" do
    context "when given a valid numerical day of month" do
      "1".upto("31") do |day_of_month|
        it "parses #{day_of_month}" do
          expect(subject.parse(day_of_month)).to eq([day_of_month.to_i])
        end
      end

      context "when given with a leading 0" do
        "01".upto("31") do |day_of_month|
          it "parses #{day_of_month}" do
            expect(subject.parse(day_of_month)).to eq([day_of_month.to_i])
          end
        end
      end
    end

    it "raises an error if given 0" do
      expect {
        subject.parse("0")
      }.to raise_error(
             CrontabParse::ParserError,
             "Invalid day of month value: [0]. Valid day of month values are integers between 0 and 31."
           )
    end

    context "when given a range" do
      it "parses 20-31" do
        expect(subject.parse("20-31")).to eq((20..31).to_a)
      end

      context "when given an invalid range" do
        it "raises an error" do
          expect {
            subject.parse("24-32")
          }.to raise_error(
                 CrontabParse::ParserError,
                 "Invalid day of month value: [24-32]. Valid day of month values are integers between 0 and 31."
               )
        end
      end
    end

    context "with , separated values" do
      it "parses a list of day of month" do
        expect(subject.parse("4,6,23")).to eq([4, 6, 23])
      end

      context "when list value contains an out of bound value" do
        it "parses raises an error" do
          expect do
            subject.parse("4,6,60,50")
          end.to raise_error(
                   CrontabParse::ParserError,
                   "Invalid day of month value: [4,6,60,50]. Valid day of month values are integers between 0 and 31."
                 )
        end
      end
    end

    context "when give a stepped value" do
      it "parses */12" do
        expect(subject.parse("*/12")).to eq([1, 13, 25])
      end

      context "when given and invalid stepped value" do
        it "raises an error" do
          expect {
            subject.parse("*/32")
          }.to raise_error(
                 CrontabParse::ParserError,
                 "Invalid day of month value: [*/32]. Valid day of month values are integers between 0 and 31."
               )
        end
      end
    end
  end
end

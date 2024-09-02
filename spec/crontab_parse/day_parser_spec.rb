require "spec_helper"
require "crontab_parse/day_parser"

RSpec.describe CrontabParse::DayParser do
  describe "#parse" do
    context "when given a valid numerical day" do
      "1".upto("6") do |day|
        it "parses #{day}" do
          expect(subject.parse(day)).to eq([day.to_i])
        end
      end

      context "when given with a leading 0" do
        "01".upto("6") do |day_of_month|
          it "parses #{day_of_month}" do
            expect(subject.parse(day_of_month)).to eq([day_of_month.to_i])
          end
        end
      end
    end

    context "with an invalid numerical day" do
      it "raises an error " do
        expect {
          subject.parse("7")
        }.to raise_error(
               CrontabParse::ParserError,
               "Invalid day value: [7]. Valid day values are integers between 0 and 6."
             )
      end
    end

    context "when given a range" do
      it "parses 2-5" do
        expect(subject.parse("2-5")).to eq((2..5).to_a)
      end

      context "when given an invalid range" do
        it "raises an error" do
          expect {
            subject.parse("2-32")
          }.to raise_error(
                 CrontabParse::ParserError,
                 "Invalid day value: [2-32]. Valid day values are integers between 0 and 6."
               )
        end
      end
    end

    context "with , separated values" do
      it "parses a list of day" do
        expect(subject.parse("4,6")).to eq([4, 6])
      end

      context "when list value contains an out of bound value" do
        it "parses raises an error" do
          expect do
            subject.parse("4,6,60")
          end.to raise_error(
                   CrontabParse::ParserError,
                   "Invalid day value: [4,6,60]. Valid day values are integers between 0 and 6."
                 )
        end
      end
    end

    context "when give a stepped value" do
      it "parses */3" do
        expect(subject.parse("*/3")).to eq([0, 3, 6])
      end

      context "when given and invalid stepped value" do
        it "raises an error" do
          expect {
            subject.parse("*/32")
          }.to raise_error(
                 CrontabParse::ParserError,
                 "Invalid day value: [*/32]. Valid day values are integers between 0 and 6."
               )
        end
      end
    end

    it "parses the wildcard" do
      expect(subject.parse("*")).to eq((0..6).to_a)
    end

    context "when give 3 letters day name" do
      %w[MON TUE WED THU FRI SAT SUN].each_with_index do |day, index|
        it "parses #{day}" do
          expect(subject.parse(day)).to eq([index + 1])
        end
      end

      %w[MON TUE WED THU FRI SAT SUN].each_with_index do |day, index|
        it "parses #{day}" do
          expect(subject.parse(day)).to eq([index + 1])
        end
      end
    end
  end
end

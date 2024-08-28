require 'spec_helper'

RSpec.describe CrontabParse::Parser::HourParser do
  subject { described_class.new(hour) }

  describe "#parse" do
    context "when given a valid numerical hour" do
      let(:hour) { "3" }

      it "parses the hour" do
        expect(subject.parse).to eq([hour.to_i])
      end

      context "with a leading 0" do
        let(:hour) { "04" }

        it "parses the minute" do
          expect(subject.parse).to eq([4])
        end
      end

      context "with a for leading 1" do
        let(:hour) { "19" }

        it "parses the minute" do
          expect(subject.parse).to eq([hour.to_i])
        end
      end

      context "with a leading 2" do
        let(:hour) { "23" }

        it "parses the minute" do
          expect(subject.parse).to eq([hour.to_i])
        end

        context "when give a value greater than 23" do
          let(:hour) { "24" }
          it "raises an error" do
            expect { subject.parse }
              .to raise_error(
                    CrontabParse::ParserError,
                    "Invalid hour value: [#{hour}]. Valid hour values are integers between 0 and 23."
                  )
          end
        end

        describe "stepped values" do
          let(:hour) { "*/8" }

          it "parses the minutes" do
            expect(subject.parse).to eq([0, 8, 16])
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe CrontabParse do
  describe ".parse" do
    context "Simple Schedules" do
      let(:crontab) { '* * * * * /bin/echo "Hello, world!"' }

      it "successfuly parses the crontab" do
        expect(described_class.parse(crontab))
          .to eq(
                minutes: (0..59).to_a,
                hours: (0..23).to_a,
                day_of_month: (1..31).to_a,
                months: (1..12).to_a,
                day_of_week: (1..7).to_a
              )
      end

      describe "parses minutes" do
        let(:crontab) { "#{minute} * * * * /bin/echo \"Hello, world!\"" }

      end
    end
  end
end

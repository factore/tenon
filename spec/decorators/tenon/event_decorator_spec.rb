require 'spec_helper'

describe EventDecorator do
  let(:ed) { EventDecorator.new(event) }
  let!(:time) { Time.now }

  describe '#display_date' do
    context 'a single day event' do
      let(:event) { double(starts_at: time, ends_at: time + 1.hour) }

      it "should show the day and the times" do
        str = "#{time.strftime('%B %d, %Y')} from #{time.strftime('%I:%M%p')} until #{(time + 1.hour).strftime('%I:%M%p')}"
        expect(ed.display_date).to eq str
      end
    end

    context 'a multi-day event' do
      let(:event) { double(starts_at: time, ends_at: time + 2.days) }

      it "should show the start day and time and the end day and time" do
        str = "#{time.strftime("%B %d, %Y at %I:%M%p")} until #{(time + 2.days).strftime("%B %d, %Y at %I:%M%p")}"
        expect(ed.display_date).to eq str
      end
    end
  end
end

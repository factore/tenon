require 'spec_helper'

describe Event do
  describe '.on' do
    let(:year) { 2014 }
    let(:month) { 3 }
    let(:day) { 10 }

    context 'when year, month, and day are passed' do
      it "should find events on that exact day" do
        args = [
          'starts_at > ? AND starts_at < ?',
          Time.mktime(year, month, day),
          Time.mktime(year, month, day) + 1.day
        ]
        expect(Event).to receive(:where).with(*args) { Event }
        Event.on(year, month, day)
      end
    end

    context 'when year and month are passed' do
      it "should find events in that month" do
        args = [
          'starts_at > ? AND starts_at < ?',
          Time.mktime(year, month, nil),
          Time.mktime(year, month, nil) + 1.month
        ]
        expect(Event).to receive(:where).with(*args) { Event }
        Event.on(year, month, nil)
      end
    end

    context 'when year is passed' do
      it "should find events in that year" do
        args = [
          'starts_at > ? AND starts_at < ?',
          Time.mktime(year, nil, nil),
          Time.mktime(year, nil, nil) + 1.year
        ]
        expect(Event).to receive(:where).with(*args) { Event }
        Event.on(year, nil, nil)
      end
    end

    context 'when year and day are passed' do
      it "should raise an ArgumentError" do
        expect { Event.on(year, nil, day) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#to_param' do
    it "should include the ID and the title" do
      e = Event.new(title: 'Test Title')
      e.stub(:id) { 1 }
      expect(e.to_param).to eq('1-test-title')
    end
  end

  describe '#next' do
    it "should look for the first event whose start time is greater" do
      t = Time.now
      args = ['starts_at > ?', t]
      expect(Event).to receive(:published) { Event }
      expect(Event).to receive(:where).with(*args) { [] }
      Event.new(starts_at: t).next
    end
  end

  describe '#previous' do
    it "should look for the first event whose start time is greater" do
      t = Time.now
      args = ['starts_at < ?', t]
      expect(Event).to receive(:published) { Event }
      expect(Event).to receive(:where).with(*args) { [] }
      Event.new(starts_at: t).previous
    end
  end
end

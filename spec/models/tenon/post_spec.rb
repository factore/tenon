require 'spec_helper'

describe Tenon::Post do
  describe '#to_param' do
    it 'should include the ID and the title' do
      p = Tenon::Post.new(title: 'Test Title')
      p.stub(:id) { 1 }
      expect(p.to_param).to eq('1-test-title')
    end
  end

  describe '#next' do
    it 'should look for the first post whose publish_at is greater' do
      t = Time.now
      args = ['publish_at > ?', t]
      expect(Tenon::Post).to receive(:posted) { Tenon::Post }
      expect(Tenon::Post).to receive(:where).with(*args) { [] }
      Tenon::Post.new(publish_at: t).next
    end
  end

  describe '#previous' do
    it 'should look for the first event whose start time is greater' do
      t = Time.now
      args = ['publish_at < ?', t]
      expect(Tenon::Post).to receive(:posted) { Tenon::Post }
      expect(Tenon::Post).to receive(:where).with(*args) { [] }
      Tenon::Post.new(publish_at: t).previous
    end
  end

  describe 'posted?' do
    let(:post) { Tenon::Post.new(publish_at: publish_at) }
    context 'when publish_at in the past' do
      let(:publish_at) { Time.now - 1.day }
      it 'should be true' do
        expect(post.posted?).to be_true
      end
    end

    context 'when publish_at in the future' do
      let(:publish_at) { Time.now + 1.day }
      it 'should not be true' do
        expect(post.posted?).not_to be_true
      end
    end
  end
end

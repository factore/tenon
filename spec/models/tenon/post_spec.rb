require 'spec_helper'

describe Post do
  describe '#to_param' do
    it "should include the ID and the title" do
      p = Post.new(title: 'Test Title')
      p.stub(:id) { 1 }
      expect(p.to_param).to eq('1-test-title')
    end
  end

  describe '#next' do
    it "should look for the first post whose created_at is greater" do
      t = Time.now
      args = ['created_at > ?', t]
      expect(Post).to receive(:posted) { Post }
      expect(Post).to receive(:where).with(*args) { [] }
      Post.new(created_at: t).next
    end
  end

  describe '#previous' do
    it "should look for the first event whose start time is greater" do
      t = Time.now
      args = ['created_at < ?', t]
      expect(Post).to receive(:posted) { Post }
      expect(Post).to receive(:where).with(*args) { [] }
      Post.new(created_at: t).previous
    end
  end

  describe "posted?" do
    let(:post) { Post.new(published: published, created_at: created_at) }
    context "when published and created_at in the past" do
      let(:published) { true }
      let(:created_at) { Date.today - 1.day }
      it "should be true" do
        expect(post.posted?).to be_true
      end
    end

    context "when not published and created_at in the future" do
      let(:published) { false }
      let(:created_at) { Date.today + 1.day }
      it "should not be true" do
        expect(post.posted?).not_to be_true
      end
    end

    context "when published and created_at in the future" do
      let(:published) { true }
      let(:created_at) { Date.today + 1.day }
      it "should not be true" do
        expect(post.posted?).not_to be_true
      end
    end

    context "when not published and created_at in the past" do
      let(:published) { false }
      let(:created_at) { Date.today - 1.day }
      it "should not be true" do
        expect(post.posted?).not_to be_true
      end
    end
  end
end

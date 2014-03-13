require 'spec_helper'

describe ApplicationDecorator do
  let(:ad) { ApplicationDecorator.new(obj) }
  let(:obj) { Post.new }

  describe '#edit_path' do
    it "should call url_for" do
      expect(ad.h).to receive(:url_for).with [:edit, :tenon, obj]
      ad.edit_path
    end
  end

  describe '#edit_link' do
    it "should call edit_link" do
      expect(ad.h).to receive(:edit_link).with(obj, {})
      ad.edit_link
    end
  end

  describe '#delete_link' do
    it "should call delete_link" do
      expect(ad.h).to receive(:delete_link).with(obj, {})
      ad.delete_link
    end
  end

  describe '#published?' do
    context "when object responds_to publish_at" do
      before do
        obj.stub(:publish_at) { publish_at }
      end
      context "when publish_at is in the future" do
        let(:publish_at) { Time.now + 1.day }
        it "should not be true" do
          expect(ad.published?).not_to be_true
        end
      end

      context "when publish_at is in the past" do
        let(:publish_at) { Time.now - 1.second }
        it "should be true" do
          expect(ad.published?).to be_true
        end
      end
    end

    context "when object responds_to published" do
      before do
        obj.stub(:published) { published }
      end

      context "when not published" do
        let(:published) { false }
        it "should not be true" do
          expect(ad.published?).not_to be_true
        end
      end

      context "when published" do
        let(:published) { true }
        it "should be true" do
          expect(ad.published?).to be_true
        end
      end
    end

    context "when object doesn't respond_to published or publish_at" do
      let(:obj) { double }
      it "should be true" do
        expect(ad.published?).to be_true
      end
    end
  end
end

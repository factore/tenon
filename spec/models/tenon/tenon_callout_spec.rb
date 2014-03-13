require 'spec_helper'

describe Tenon::TenonCallout do
  describe ".published" do
    it "should find callouts that are published" do
      expect(Tenon::TenonCallout).to receive(:where).with(published: true)
      Tenon::TenonCallout.published
    end
  end
end

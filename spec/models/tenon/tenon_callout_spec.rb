require 'spec_helper'

describe TenonCallout do
  describe ".published" do
    it "should find callouts that are published" do
      expect(TenonCallout).to receive(:where).with(published: true)
      TenonCallout.published
    end
  end
end

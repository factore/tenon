require 'spec_helper'

describe Tenon::User do
  let(:user) { Tenon::User.new }

  ['Admin', 'Super Admin', 'Contributor', 'Member'].each do |role|
    describe "is_#{role.dehumanize}?" do
      context "when the user has the role of #{role}" do
        let(:role) { double }
        before do
          Tenon::Role.stub(:find_by_title) { role }
          user.stub(:roles) { [role] }
        end

        it "should be true" do
          expect(user.send("is_#{role.dehumanize}?")).to be_true
        end
      end

      context "when the user has the role of #{role}" do
        let(:role) { double }
        before do
          Tenon::Role.stub(:find_by_title) { role }
          user.stub(:roles) { [] }
        end

        it "should not be true" do
          expect(user.send("is_#{role.dehumanize}?")).not_to be_true
        end
      end
    end
  end

  describe "#as_json" do
    it "should include the is_admin? method" do
      expect(Tenon::User.new.as_json.keys).to include("is_admin?")
    end
  end

  describe '#staff?' do
    %w{is_super_admin? is_admin? is_contributor?}.each do |role|
      context "when user #{role}" do
        before do
          user.stub(role) { true }
        end

        it "should be true" do
          expect(user.staff?).to be_true
        end
      end
    end

    context "when user is not a super_admin, admin, or contributor" do
      it "should not be true" do
        expect(user.staff?).not_to be_true
      end
    end
  end
end

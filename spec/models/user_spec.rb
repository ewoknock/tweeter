require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_tweets).through(:bookmarks).source(:tweet) }
  it { should have_many(:follows).dependent(:destroy) }
  it { should have_many(:following_users).through(:follows) }
  it { should have_many(:reverse_follows).with_foreign_key(:following_user_id).class_name("Follow") }
  it { should have_many(:followers).through(:reverse_follows).source(:user) }

  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe "#set_display_name" do
    context "when display_name is set" do
      it "does not change the display_name" do
        user = build(:user, username: "test", display_name: "Tweet Tester")
        user.save
        expect(user.reload.display_name).to eq("Tweet Tester")
      end
    end

    context "when display_name is not set" do
      it "humanizes the previously set username" do
        user = build(:user, username: "test", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("Test")
      end
      
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }
  it { should have_many(:bookmarks).dependent(:destroy)}
  it { should have_many(:bookmarked_tweets).through(:bookmarks).source(:tweet) }

  it { should validate_uniqueness_of(:username).case_insensitive }
end

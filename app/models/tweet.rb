class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  has_many :replies, inverse_of: :parent_tweet, class_name: "Tweet"
  belongs_to :parent_tweet, class_name: "Tweet", optional: true

  validates :body, presence: true, length: { maximum: 280 }
end

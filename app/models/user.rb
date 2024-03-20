class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_tweets, through: :bookmarks, source: :tweet
  has_many :follows, dependent: :destroy
  has_many :following_users, through: :follows
  has_many :reverse_follows, foreign_key: :following_user_id, class_name: "Follow"
  has_many :followers, through: :reverse_follows, source: :user

  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true
  
  before_save :set_display_name, if: -> { display_name.blank? }

  def set_display_name
    self.display_name = username.humanize unless username.nil?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end

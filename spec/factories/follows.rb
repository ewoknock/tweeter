FactoryBot.define do
  factory :follow do
    user
    following_user do
      user
    end
  end
end

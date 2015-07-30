FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    username 'test-user'
    password "123123"
    password_confirmation { "123123" }
  end

  factory :gif_post do
    association :user
    body 'test'
  end
end

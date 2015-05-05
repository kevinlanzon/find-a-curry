FactoryGirl.define do
  factory :user do |user|
    user.email 'test@test.com'
    user.password 'testing1234'
  end
end
FactoryGirl.define do
  factory :user do
  	sequence(:name) { |n| "User name #{n}" }
    email { FactoryGirl.generate(:email) }
    password 'foobar'
    password_confirmation { |u| u.password }
  end
end
FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@foobar.com"
  end
end
require 'faker'

FactoryBot.define do
  factory :user do

      #sequence(:username){|n| "test#{n}"}
      username Faker::Name.unique.name

      email "test#{Faker::Name.unique.first_name}@test.com"
      #sequence(:email){|n| "test#{n}@test.com"}

      password "password"
      activated true
  end
end

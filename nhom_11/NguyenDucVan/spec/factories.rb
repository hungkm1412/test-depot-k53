FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "123123"
    password_confirmation "123123"

    factory :admin do
    	admin true
    end
  end
end

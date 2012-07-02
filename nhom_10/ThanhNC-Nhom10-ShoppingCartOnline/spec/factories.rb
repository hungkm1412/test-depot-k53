FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :product do
    sequence(:pro_id)  { |n| "#{n}" }
    sequence(:name) { |n| "Product_#{n}"} 
    detail "abc"
    price "10"
  end
end
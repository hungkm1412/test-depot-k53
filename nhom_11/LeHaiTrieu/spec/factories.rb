FactoryGirl.define do
	factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" } 
    password	"foobar"
    password_confirmation	"foobar"

    factory :admin do
      admin true
    end
	end

  factory :category do
    name "Category name"
  end

  factory :product do
    name "Product name"
    category
  end
end
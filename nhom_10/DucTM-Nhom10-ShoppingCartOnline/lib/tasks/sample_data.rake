namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_categories
    make_products
  end
end

def make_users
  admin = User.create!(name:     "admin",
                       email:    "a@b.c",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  50.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_categories
  20.times do |n|
    name = Faker::Company.name
    Category.create!(name: name)
  end
end

def make_products
  categories = Category.all(limit: 6)
  25.times do
    name  = Faker::Name.name
    categories.each { |category| category.products.create!(name: name, price: 100) }
  end
end


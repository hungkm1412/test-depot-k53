namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_categories
    make_products
  end
end

def make_users
  admin = User.create!(name:     "Admin",
                       email:    "admin@gmail.com",
                       password: "123456",
                       password_confirmation: "123456")
  admin.toggle!(:admin)
  20.times do |n|
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
    name  = Faker::Name.name
    Category.create!(name:     name)
  end
end

def make_products
  categories = Category.all(limit: 6)
  6.times do
    name = Faker::Name.name
    price = rand(1000)
    categories.each { |category| category.products.create!(name: name,price: price) }
  end
end


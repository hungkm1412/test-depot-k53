namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_categories
    make_products
  end
end

def make_users
  admin = User.create!(name: "admin",
   email:    "example@railstutorial.org",
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
  10.times do
    name = Faker::Company.name
    Category.create!(name: name)
  end
end

def make_products
  categories = Category.all(limit: 6)
  10.times do
    name = Faker::Lorem.sentence(2)
    price = 10000 * Random.rand(100)
    number = 1+ Random.rand(30)
    categories.each { |category| category.products.create!(name: name, price: price, category_id: category.id) }
  end
end
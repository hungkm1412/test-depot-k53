namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_categories
    make_products
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Tung Dao",
                       email: "admin@gmail.com",
                       phone: "01652397189",
                       address: "52 TNT",
                       password: "s3cr3t",
                       password_confirmation: "s3cr3t")
  admin.toggle!(:admin)

  non_admin = User.create!(name: "Normal",
                           email: "normal@gmail.com",
                           phone: "01652397189",
                           address: "52 TNT",
                           password: "s3cr3t",
                           password_confirmation: "s3cr3t")

  password  = "password"
  30.times do |n|
    name  = Faker::Name.name
    email = Faker::Internet.email
    phone = Faker::PhoneNumber.phone_number
    address = Faker::Address.street_address
    User.create!(name: name,
                 email: email,
                 phone: phone,
                 address: address,
                 password: password,
                 password_confirmation: password)
  end
end

def make_categories
  5.times do |n|
    Category.create!(name: Faker::Company.name)
  end
end

def make_products
  50.times do |n|
    name = Faker::Lorem.sentence(2)
    description = Faker::Lorem.sentences(2)
    price = 100 + rand(1000)
    Product.create!(name: name,
                    description: description,
                    price: price)
  end
end

def make_relationships
  categories = Category.all
  count = categories.count

  Product.all.each do |p|
    p.category_id = categories[rand(count)]
    p.save
  end
end

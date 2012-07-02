namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Duc Van",
                         email: "van@mail.com",
                         password: "123123",
                         password_confirmation: "123123")
    admin.toggle!(:admin)

    4.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "123123"
			User.create!(name: name, email: email, password: password, password_confirmation: password)
		end

		5.times do |n|
			cname = Faker::Name.name
			description = "description for categories-#{n+1}"
			Category.create!(name: cname, description: description)
		end

		categories = Category.all(limit: 6)
		20.times do
			description = "description for products"
			price = 1000
			categories.each do |cat|
				pname = Faker::Name.name
				cat.products.create!(name: pname, description: description, price: price)
			end
		end
	end
end

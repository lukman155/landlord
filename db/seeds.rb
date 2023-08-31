admin = User.create!(
  full_name: 'The Admin',
  email: 'admin@a.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'admin'
)

puts 'The Admin has Awakened'

user1 = User.create!(
  full_name: "User One",
  email: "user1@example.com",
  password: "password"
)

user2 = User.create!(
  full_name: "User Two",
  email: "user2@example.com",
  password: "password"
)

users = [user1, user2]

# Create Areas
areas = ["Samaru", "Zango", "Silver"]

# Create Properties
properties = []
users.each do |user|
  areas.each do |area|
    12.times do
      rent_amount = rand(200_000..300_000)
      property = Property.new(
        landlord: user,
        street: Faker::Address.street_address,
        rent_amount: rent_amount,
        property_type: Faker::Lorem.word,
        description: Faker::Lorem.paragraph,
        property_name: Faker::Company.name,
        city: "Your City",
        state: "Your State",
        area: area,
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude
      )
      properties << property
    end
  end
end

Property.import properties, recursive: true

puts "Seed data created successfully."
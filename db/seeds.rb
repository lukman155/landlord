admin = User.create!(
  full_name: 'The Admin',
  email: 'admin@admin.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'admin'
)

puts 'The Admin has Awakened'


# def create_rooms(property, number_of_rooms, rent_amount, room_type)
#   number_of_rooms.times do |index|
#     Room.create!(
#       property: property,
#       rent_amount: rent_amount,
#       room_type: room_type,
#       room_number: index + 1
#     )
#   end
# end

# # Create Users
# user1 = User.create!(
#   full_name: "User One",
#   email: "user1@example.com",
#   password: "password"
# )

# user2 = User.create!(
#   full_name: "User Two",
#   email: "user2@example.com",
#   password: "password"
# )

# users = [user1, user2]

# # Create Areas
# areas = ["Samaru", "Zango", "Silver"]

# # Room Types
# room_types = [
#   "One Bedroom Ensuite",
#   "Two Bedroom Ensuite",
#   "One Bed Ensuite (Large)",
#   "Studio Apartment",
#   "Shared Room",
#   # Add more room types as needed
# ]

# # Create Properties with Rooms
# # Create Properties with Rooms
# users.each do |user|
#   areas.each do |area|
#     8.times do
#       rent_amount = rand(200_000..300_000)
#       street_name = Faker::Address.street_name
#       room_type_name = room_types.sample
#       number_of_rooms = rand(6..8)
      
#       property = Property.create!(
#         landlord: user,
#         street: street_name,
#         rent_amount: rent_amount,
#         property_type: Faker::Lorem.word,
#         description: Faker::Lorem.paragraph,
#         property_name: street_name,
#         city: "Zaria",
#         state: "Kaduna",
#         area: area,
#         latitude: Faker::Address.latitude,
#         longitude: Faker::Address.longitude
#       )
      
#       create_rooms(
#         property,
#         number_of_rooms,
#         property.rent_amount,
#         room_type_name
#       )
#     end
#   end
# end

# puts "Seed data created successfully."

admin = User.create!(
  email: 'admin@example.com',
  password: 'yourpassword',
  password_confirmation: 'yourpassword',
  role: 'admin'
)

puts 'The Admin has Awakened'
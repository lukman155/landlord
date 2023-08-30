admin = User.create!(
  full_name: 'The Admin',
  email: 'admin@a.com',
  password: '123456',
  password_confirmation: '123456',
  role: 'admin'
)

puts 'The Admin has Awakened'
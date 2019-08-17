require 'faker'

User.create(
  name: "管理者",
  email: "admin@email.com",
  admin: true,
  password: "adminpassword",
  password_confirmation: "adminpassword"
  )

15.times do |i|
  User.create(
    name: Faker::Name.name,
    email: "test#{i + 1}@mail.com",
    password: "password",
    password_confirmation: "password"
    )
end
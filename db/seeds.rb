# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  User.where(id: 1..20).each do |user|
    user.avatar.attach(io: File.open("#{Rails.root}/spec/fixtures/files/images/avatar_test.png"), filename: "user_avater_#{user.id}.png")
  end
end

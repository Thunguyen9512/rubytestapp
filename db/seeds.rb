# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do 
    Book.create({
        name: Faker::Book.title,
        author_id: '1',
        quantity: Faker::Number.decimal_part(digits: 2),
        public_year: '1975',
        pulisher_id: '1',
        category_id: '1',
    })
end

# 5.times do 
#     Author.create({
#         name: Faker::Book.title,
#         note: 'author note'
#     })
# end

# 5.times do 
#     Publisher.create({
#         name: Faker::Book.publisher,
#         address: Faker::Address.street_address,
#         email: Faker::Internet.email,
#         phone_number: Faker::PhoneNumber.phone_number,
#     })
# end

# 5.times do 
#     Category.create({
#         name: Faker::Book.genre,
#     })
# end


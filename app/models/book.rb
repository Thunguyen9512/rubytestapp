class Book < ApplicationRecord
    belongs_to :author, foreign_key: 'author_id'
    belongs_to :publisher, foreign_key: 'pulisher_id'
    belongs_to :category, foreign_key: 'category_id'
    has_many :orders, foreign_key: 'book_id'
end

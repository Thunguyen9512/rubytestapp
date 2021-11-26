class Category < ApplicationRecord
    has_many :books, foreign_key: 'category_id'
end

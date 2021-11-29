class Publisher < ApplicationRecord
    has_many :books, foreign_key: 'pulisher_id', dependent: :destroy
end

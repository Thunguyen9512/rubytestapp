class Order < ApplicationRecord
    belongs_to :user, foreign_key: 'reader_id'
    belongs_to :user, foreign_key: 'staff_id'
    has_many :order_books, dependent: :destroy
end

class OrderBook < ApplicationRecord
    belongs_to :order, foreign_key: 'order_id'
    belongs_to :book, foreign_key: 'book_id'
end

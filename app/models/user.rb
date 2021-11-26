class User < ApplicationRecord
    # validates :name, presence: true
    # validates :password,presence: true, length: { minimum: 8 }
    has_many :orders, foreign_key: 'reader_id'
    has_many :orders, foreign_key: 'staff_id'
end

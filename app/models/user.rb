class User < ApplicationRecord
    # validates :name, presence: true
    # validates :password,presence: true, length: { minimum: 8 }
    has_many :orders, foreign_key: 'reader_id', dependent: :destroy
    has_many :orders, foreign_key: 'staff_id', dependent: :destroy
end

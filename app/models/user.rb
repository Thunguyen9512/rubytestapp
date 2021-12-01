class User < ApplicationRecord
    has_secure_password
    has_many :orders, foreign_key: 'reader_id', dependent: :destroy
    has_many :orders, foreign_key: 'staff_id', dependent: :destroy
    enum role: [:staff, :reader]
end

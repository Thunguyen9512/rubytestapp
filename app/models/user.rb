class User < ApplicationRecord
    # validates :name, presence: true
    validates :password, presence: true
    validates :user_name, presence: true, uniqueness: true
    enum role: {admin: "admin", staff: "staff", reader: "reader"}

    has_secure_password
    
    has_many :orders, foreign_key: 'reader_id', dependent: :destroy
    has_many :orders, foreign_key: 'staff_id', dependent: :destroy
end
 

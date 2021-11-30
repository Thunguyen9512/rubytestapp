class Book < ApplicationRecord
  #Lou Need foreign_key params in relationship model?
    belongs_to :author
    belongs_to :publisher
    belongs_to :category
    has_many :orders
end

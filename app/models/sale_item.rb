class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :book
  

  validates :book_id, :title, :amount, presence: true
end

class SaleItem < ApplicationRecord
  belongs_to :sale, counter_cache: true
  belongs_to :book
  

  validates :book_id, :title, :amount, presence: true
end

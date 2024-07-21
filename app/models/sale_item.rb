class SaleItem < ApplicationRecord
  belongs_to :sale, counter_cache: true
  belongs_to :book
  
  after_create :reduce_book_stock

  validates :book_id, :title, :amount, presence: true

  private

  def reduce_book_stock
    sale_items.each do |item|
      book = item.book
      book.reduce_stock(item.quantity)
    end
  end
  
end

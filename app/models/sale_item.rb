class SaleItem < ApplicationRecord
  belongs_to :sale, counter_cache: true
  belongs_to :book
  
  after_create :reduce_book_stock

  validates :book_id, :title, :amount, presence: true

  private

  def reduce_book_stock
    book.reduce_stock(1) if book.present?
  end

end

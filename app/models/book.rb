class Book < ApplicationRecord
  belongs_to :account
  has_many :sale_items

  validates :title, :price, :number_of_books, :stock, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  enum book_type: [:textbook, :manual]

  # Method to reduce stock when a sale is made
  def reduce_stock(quantity)
    update(stock: stock - quantity)
  end

  # Method to increase stock when restocking
  def restock(quantity)
    update(stock: stock + quantity)
  end


  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "amount", "book_type", "course_code", "created_at", "id", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["account"]
  end
end

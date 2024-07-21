class Sale < ApplicationRecord
  belongs_to :student
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items

  validates :total_amount, presence: true
  validates :cashier_name, presence: true

  # def reduce_book_stock
  #   sale_items.each do |item|
  #     book = item.book
  #     book.reduce_stock(1) if book.present?
  #   end
  # end

  def self.ransackable_attributes(auth_object = nil)
  ["cashier_name", "mat_no", "created_at", "id", "sale_items_count", "student_id", "total_amount", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
  ["sale_items", "student"]
  end
end

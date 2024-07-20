class Sale < ApplicationRecord
  belongs_to :student
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items

  validates :total_amount, presence: true
  validates :cashier_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
  ["cashier_name", "mat_no", "created_at", "id", "sale_items_count", "student_id", "total_amount", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
  ["sale_items", "student"]
  end
end

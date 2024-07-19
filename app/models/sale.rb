class Sale < ApplicationRecord
  belongs_to :student
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items

  validates :total_amount, presence: true
  validates :cashier_name, presence: true
end

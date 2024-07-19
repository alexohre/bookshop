class Book < ApplicationRecord
  belongs_to :account
  has_many :sale_items


  enum book_type: [:textbook, :manual]


  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "amount", "book_type", "course_code", "created_at", "id", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["account"]
  end
end

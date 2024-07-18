class Book < ApplicationRecord
  belongs_to :account

  enum book_type: [:textbook, :manual]
end

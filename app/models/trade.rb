class Trade < ApplicationRecord
  belongs_to :account
  belongs_to :currency_pair
  enum time_duration: { "1 Min": 1, "5 Mins": 5, "10 Mins": 10, "15 Mins": 15, "30 Mins": 30, "1 Hr": 60, "3 Hrs": 180, "12 Hrs": 720, "1 Day": 1440 }
  enum status: { "running": 0, "completed": 1, "cancelled": 2 }
end
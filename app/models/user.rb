class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  before_create :generate_username

  has_one_attached :avatar, dependent: :destroy

  validates :username, presence: true, unless: :new_record?

  enum role: [:admin, :staff, :supervisor]

  def self.ransackable_attributes(auth_object = nil)
    ["email", "first_name", "id", "last_name", "role", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob"]
  end

  private

  def generate_username
    # Split email at "@" and append 6 random characters
    prefix, domain = email.split('@')
    random_chars = SecureRandom.hex(3) # 6 random characters in hexadecimal form
    self.username = "#{prefix}_#{random_chars}"
  end
end

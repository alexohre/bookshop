class Student < ApplicationRecord
  require 'csv'

  validates :first_name, :last_name, :other_name, :email, :department, :course, :level, presence: true
  validates :mat_no, uniqueness: true
  
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      student_hash = row.to_hash
      Student.create!(student_hash)
    end
  end


  
  def self.ransackable_attributes(auth_object = nil)
    ["course", "created_at", "department", "email", "first_name", "id", "last_name", "level", "mat_no", "other_name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end

class AddCourseCodeToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :course_code, :string
  end
end

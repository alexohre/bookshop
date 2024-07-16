class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :other_name
      t.string :mat_no
      t.string :email
      t.string :department
      t.string :course
      t.string :level

      t.timestamps
    end
  end
end

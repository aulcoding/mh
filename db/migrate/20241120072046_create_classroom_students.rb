class CreateClassroomStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :classroom_students do |t|
      t.integer :year
      t.integer :semester
      t.references :classroom, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end

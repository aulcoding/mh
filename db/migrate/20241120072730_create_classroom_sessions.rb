class CreateClassroomSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :classroom_sessions do |t|
      t.date :session_date
      t.integer :year
      t.integer :semester
      t.references :classroom_student, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :manuscript, null: false, foreign_key: true
      t.references :manuscript_status, null: false, foreign_key: true
      t.references :attendance_status, null: false, foreign_key: true
      t.string :attendance_remarks

      t.timestamps
    end
  end
end

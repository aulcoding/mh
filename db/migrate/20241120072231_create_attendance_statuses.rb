class CreateAttendanceStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :attendance_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end

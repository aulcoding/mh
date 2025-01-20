class ChangeAttendanceStatusIdToNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :classroom_sessions, :attendance_status_id, true
  end
end

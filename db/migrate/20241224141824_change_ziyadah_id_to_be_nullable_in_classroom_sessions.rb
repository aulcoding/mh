class ChangeZiyadahIdToBeNullableInClassroomSessions < ActiveRecord::Migration[7.1]
  def change
    change_column_null :classroom_sessions, :ziyadah_id, true
  end
end

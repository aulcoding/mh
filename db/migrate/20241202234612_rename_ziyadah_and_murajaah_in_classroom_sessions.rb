class RenameZiyadahAndMurajaahInClassroomSessions < ActiveRecord::Migration[7.1]
  def change
    rename_column :classroom_sessions, :ziyadah, :ziyadah_id
    rename_column :classroom_sessions, :murajaah, :murajaah_id
  end
end

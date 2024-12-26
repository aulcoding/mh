class RenameZiyadahAndMurajaahInClassroomSessions2 < ActiveRecord::Migration[7.1]
  def change
    rename_column :classroom_sessions, :ziyadah_id, :ziyadah
    rename_column :classroom_sessions, :murajaah_id, :murajaah
  end
end

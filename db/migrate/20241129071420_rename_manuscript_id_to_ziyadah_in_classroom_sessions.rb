class RenameManuscriptIdToZiyadahInClassroomSessions < ActiveRecord::Migration[7.1]
  def change
    rename_column :classroom_sessions, :manuscript_id, :ziyadah
  end
end

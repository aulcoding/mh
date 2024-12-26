class RemoveManuscriptStatusIdFromClassroomSessions < ActiveRecord::Migration[7.1]
  def change
    remove_column :classroom_sessions, :manuscript_status_id, :integer
  end
end

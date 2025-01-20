class AddZiyadahEndAndMurajaahEndToClassroomSessions < ActiveRecord::Migration[7.1]
  def up
    rename_column :classroom_sessions, :ziyadah_id, :ziyadah_start
    rename_column :classroom_sessions, :murajaah_id, :murajaah_start
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
    add_column :classroom_sessions, :ziyadah_end, :integer, null: true
    add_column :classroom_sessions, :murajaah_end, :integer, null: true
  end

  def down
    remove_column :classroom_sessions, :ziyadah_end
    remove_column :classroom_sessions, :murajaah_end
    rename_column :classroom_sessions, :ziyadah_start, :ziyadah_id
    rename_column :classroom_sessions, :murajaah_start, :murajaah_id
  end
end

class AddZiyadahToClassroomSession < ActiveRecord::Migration[7.1]
  def change
    add_column :classroom_sessions, :murajaah, :integer
  end
end

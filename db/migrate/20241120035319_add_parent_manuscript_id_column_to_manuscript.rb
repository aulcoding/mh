class AddParentManuscriptIdColumnToManuscript < ActiveRecord::Migration[7.1]
  def change
    add_column :manuscripts, :parent_manuscript_id, :integer
  end
end

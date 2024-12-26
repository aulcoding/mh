class CreateManuscripts < ActiveRecord::Migration[7.1]
  def change
    create_table :manuscripts do |t|
      t.string :name

      t.timestamps
    end
  end
end

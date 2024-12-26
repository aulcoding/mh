class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :nickname
      t.references :gender, null: false, foreign_key: true
      t.date :birthdate

      t.timestamps
    end
  end
end

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.text :name
      t.datetime :date_of_birth
      t.text :nationality

      t.timestamps
    end
  end
end

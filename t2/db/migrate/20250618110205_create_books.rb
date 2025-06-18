class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.text :title
      t.text :author
      t.integer :published_year
      t.text :isbn
      t.float :price
      t.integer :stock_quantity
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end

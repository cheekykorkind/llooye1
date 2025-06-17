class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname, index: { unique: true }
      t.text :email, index: { unique: true }
      t.text :password_digest

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :active, default: false
      t.datetime :last_sign_in

      t.timestamps
      t.datetime :deleted_at
    end

    add_index :users, :email, unique: true
    add_index :users, :active
    add_index :users, [:active, :deleted_at]
  end
end
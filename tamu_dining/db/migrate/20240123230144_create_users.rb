class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :uin
      t.string :email
      t.integer :credits

      t.timestamps
    end
    add_index :users, :uin, unique: true
    add_index :users, :email, unique: true
  end
end

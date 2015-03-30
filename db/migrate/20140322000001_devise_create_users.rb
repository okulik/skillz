class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email, :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.datetime :remember_created_at
      t.references :rolable, polymorphic: true, index: true
      t.timestamps
    end

    add_index :users, :email, :unique => true
  end
end

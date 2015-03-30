class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_column :workers, :skills, :text, array: true, default: '{}'
    add_index :workers, :skills, :using => 'gin'
  end
end

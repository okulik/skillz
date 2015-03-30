class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :worker, index: true
      t.belongs_to :customer, index: true
      t.string :description, null: false, default: ""
      t.date :start_date, null: false, index: true
      t.date :end_date, null: false, index: true
      t.timestamps
    end
  end
end

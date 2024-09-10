class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.date :date
      t.time :hour_start
      t.time :hour_end
      t.float :payment_hour
      t.integer :job_type
      t.integer :job_mode
      t.integer :function
      t.text :description
      t.text :responsibility
      t.text :requirement
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

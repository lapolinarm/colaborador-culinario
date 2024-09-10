class CreateJobUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :job_users do |t|
      t.integer :status
      t.integer :payment_method_used
      t.float :amount_paid
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end

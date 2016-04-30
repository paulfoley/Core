class CreateQuickbooksPayments < ActiveRecord::Migration
  def change
    create_table :quickbooks_payments do |t|
      t.timestamps null: false
      t.integer :org_id
      t.integer :quickbooks_customer_id
      t.string :payment_id
      t.string :sync_token
      t.string :domain
      t.string :payment_ref_num
      t.string :txn_date
      t.boolean :process_payments
      t.boolean :sparse
      t.decimal :unapplied_amt
      t.decimal :total_amt
      t.date :date_created
    end
  end
end

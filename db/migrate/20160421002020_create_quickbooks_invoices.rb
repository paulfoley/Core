class CreateQuickbooksInvoices < ActiveRecord::Migration
  def change
    create_table :quickbooks_invoices do |t|
      t.timestamps null: false
      t.integer :org_id
      t.integer :quickbooks_customer_id
      t.string :sync_token
      t.string :doc_number
      t.string :due_date
      t.string :invoice_id
      t.string :print_status
      t.string :email_status
      t.string :domain
      t.string :txn_date
      t.decimal :balance
      t.decimal :total_amt
      t.boolean :allow_online_ach_payment
      t.boolean :allow_online_payment
      t.boolean :allow_ipn_payment
      t.boolean :apply_tax_after_discount
      t.boolean :allow_online_credit_card_payment
      t.boolean :sparse
      t.date :date_created
    end
  end
end

class CreateQuickbooksInvoices < ActiveRecord::Migration
  def change
    create_table :quickbooks_invoices do |t|

      t.timestamps null: false
    end
  end
end

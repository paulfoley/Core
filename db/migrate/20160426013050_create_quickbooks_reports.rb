class CreateQuickbooksReports < ActiveRecord::Migration
  def change
    create_table :quickbooks_reports do |t|

      t.string :report_id
      t.timestamps null: false
    end
  end
end

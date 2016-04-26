class CreateQuickbooksReports < ActiveRecord::Migration
  def change
    create_table :quickbooks_reports do |t|

      t.string :report_id
      t.timestamps null: false
    end

    QuickbooksReport.create :report_id => "reportid"

  end
end

class CreateQuickbooksReports < ActiveRecord::Migration
  def change
    create_table :quickbooks_reports do |t|
      t.string :report_id
      t.timestamps null: false
    end
    QuickbooksReport.create :report_id => "BalanceSheet"
    QuickbooksReport.create :report_id => "ProfitAndLoss"
    QuickbooksReport.create :report_id => "ProfitAndLossDetail"
    QuickbooksReport.create :report_id => "TrialBalance"
    QuickbooksReport.create :report_id => "CashFlow"
    QuickbooksReport.create :report_id => "InventoryValuationSummary"
    QuickbooksReport.create :report_id => "CustomerSales"
    QuickbooksReport.create :report_id => "ItemSales"
    QuickbooksReport.create :report_id => "DepartmentSales"
    QuickbooksReport.create :report_id => "ClassSales"
    QuickbooksReport.create :report_id => "CustomerIncome"
    QuickbooksReport.create :report_id => "CustomerBalance"
    QuickbooksReport.create :report_id => "CustomerBalanceDetail"
    QuickbooksReport.create :report_id => "AgedReceivables"
    QuickbooksReport.create :report_id => "AgedReceivableDetail"
    QuickbooksReport.create :report_id => "VendorBalance"
    QuickbooksReport.create :report_id => "VendorBalanceDetail"
    QuickbooksReport.create :report_id => "AgedPayables"
    QuickbooksReport.create :report_id => "AgedPayableDetail"
    QuickbooksReport.create :report_id => "VendorExpenses"
    QuickbooksReport.create :report_id => "AccountList"
    QuickbooksReport.create :report_id => "GeneralLedger"
  end
end

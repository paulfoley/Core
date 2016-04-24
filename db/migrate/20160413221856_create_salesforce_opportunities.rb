class CreateSalesforceOpportunities < ActiveRecord::Migration
  def change
    create_table :salesforce_opportunities do |t|

      t.timestamps null: false
      t.string :account_id
      t.string :opportunity_id
      t.string :description
      t.string :forecast_category
      t.string :last_referenced_date
      t.string :close_date
      t.string :name
      t.string :stage_name
      t.string :last_viewed_date
      t.string :fiscal
      t.string :opportunity_type
      t.string :lead_source
      t.string :forecast_category_name
      t.string :last_modified_by_id
      t.string :next_step
      t.integer :probability
      t.integer :fiscal_quarter
      t.integer :salesforce_account_id
      t.integer :fiscal_year
      t.decimal :amount
      t.boolean :is_won
      t.boolean :is_deleted
      t.boolean :has_opportunity_line_item
      t.boolean :is_closed

    end
  end
end

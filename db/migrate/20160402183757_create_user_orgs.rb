class CreateUserOrgs < ActiveRecord::Migration
  def change
    create_table :user_orgs do |t|
      t.timestamps null: false
    end
  end
end

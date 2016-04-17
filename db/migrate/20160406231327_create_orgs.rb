class CreateOrgs < ActiveRecord::Migration
  def change

    create_table :orgs do |t|
      t.timestamps null: false
      t.string :name,           null: false, default: ""
      #t.has_many :users, index: true
    end

  end
end

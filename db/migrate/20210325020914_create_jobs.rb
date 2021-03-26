class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.integer :owner_id
      t.integer :user_company_id
      t.integer :client_company_id
      t.integer :client_id
      t.string :end_user
      t.string :title
      t.string :details
    end
  end
end

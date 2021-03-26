class CreateClientCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :client_companies do |t|
      t.string :name
      t.string :state
      t.string :city
      t.integer :zip_code
      t.string :address
      t.string :industry
      t.string :market
      t.integer :discount
      t.string :details
      t.integer :user_company_id
      t.integer :client_id
    end
  end
end

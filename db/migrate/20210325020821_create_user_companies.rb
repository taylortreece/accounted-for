class CreateUserCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :user_companies do |t|
      t.string :name
      t.string :state
      t.string :city
      t.integer :zip_code
      t.string :address
      t.string :industry
      t.string :market
      t.integer :user_id
    end
  end
end

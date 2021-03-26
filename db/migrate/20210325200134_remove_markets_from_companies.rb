class RemoveMarketsFromCompanies < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_companies, :market
  end
end

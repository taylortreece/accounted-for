class RemoveMarketsFromClientCompanies < ActiveRecord::Migration[6.1]
  def change
    remove_column :client_companies, :market
  end
end

class CreateClientJobTitles < ActiveRecord::Migration[6.1]
  def change
    create_table :client_job_titles do |t|
      t.string :name
      t.integer :client_id
      t.integer :client_company_id
    end
  end
end

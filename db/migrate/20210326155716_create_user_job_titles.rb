class CreateUserJobTitles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_job_titles do |t|
      t.string :name
      t.integer :user_id
      t.integer :user_company_id
    end
  end
end

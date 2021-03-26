class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :content
      t.datetime :time
      t.integer :user_id
      t.integer :user_company_id
    end
  end
end

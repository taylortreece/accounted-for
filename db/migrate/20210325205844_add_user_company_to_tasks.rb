class AddUserCompanyToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :user_company, :integer
  end
end

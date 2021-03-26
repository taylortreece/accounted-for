class ChangeColumnNameInTask < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :user_company, :user_company_id
  end
end

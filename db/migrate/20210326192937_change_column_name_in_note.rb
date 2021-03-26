class ChangeColumnNameInNote < ActiveRecord::Migration[6.1]
  def change
    rename_column :notes, :user_company, :user_company_id

  end
end

class AddUserCompanyToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :user_company, :integer
  end
end

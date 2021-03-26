class AddColumnTitleToUserAndClients < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :job_title, :string
  end

  def change
    add_column :clients, :job_title, :string
  end
end

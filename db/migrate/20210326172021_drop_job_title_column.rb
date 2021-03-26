class DropJobTitleColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :job_title
  end
end

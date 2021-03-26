class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.datetime :deadline
      t.boolean :complete
    end
  end
end

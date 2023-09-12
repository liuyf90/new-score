class RemoveForeignKeyFromTasks < ActiveRecord::Migration[7.0]
  def change
     change_column :tasks, :user_id, :integer, null: true
  end
end

class AddTypeIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :type, null: false, foreign_key: true
  end
end

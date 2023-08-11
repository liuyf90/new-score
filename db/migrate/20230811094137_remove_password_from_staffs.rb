class RemovePasswordFromStaffs < ActiveRecord::Migration[7.0]
  def change
    remove_column :staffs, :password, :digest
  end
end

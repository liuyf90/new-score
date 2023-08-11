class AddPasswordToStaffs < ActiveRecord::Migration[7.0]
  def change
    add_column :staffs, :password, :digest
  end
end

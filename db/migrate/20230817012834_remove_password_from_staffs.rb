class RemovePasswordFromStaffs < ActiveRecord::Migration[7.0]
  def change
    remove_column :staffs, :password_digest, :string
  end
end

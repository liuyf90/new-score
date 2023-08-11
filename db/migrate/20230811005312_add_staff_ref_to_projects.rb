class AddStaffRefToProjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :staff,  foreign_key: true
  end
end

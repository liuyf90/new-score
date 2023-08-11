class RemoveSponsorFromProjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :sponsor, :string
  end
end

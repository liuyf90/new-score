class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.integer :status
      t.string :mobile

      t.timestamps
    end
  end
end

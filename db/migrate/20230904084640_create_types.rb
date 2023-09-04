class CreateTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :types do |t|
      t.string :name
      t.float :point_factor

      t.timestamps
    end
  end
end

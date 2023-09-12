class CreateAccountingBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :accounting_books do |t|
      t.integer :step
      t.string :step_name
      t.float :score
      t.references :task, null: false, foreign_key: true
      t.references :staff, null: false, foreign_key: true

      t.timestamps
    end
  end
end

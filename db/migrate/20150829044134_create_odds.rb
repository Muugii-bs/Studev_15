class CreateOdds < ActiveRecord::Migration
  def change
    create_table :odds do |t|
      t.float :op1
      t.float :op2
      t.float :op3
      t.float :op4

      t.timestamps null: false
    end
  end
end

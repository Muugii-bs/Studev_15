class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :answer
      t.integer :amount
      t.integer :user_id
      t.integer :quiz_id

      t.timestamps null: false
    end
  end
end

class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :income
      t.string :description
      t.integer :amount
      t.date :date

      t.timestamps
    end
  end
end

class AddBalanceInitialToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :balance_initial, :integer
  end
end

class RemoveTransactionIdFromTransaction < ActiveRecord::Migration
  def up
    remove_column :transactions, :transaction_id
  end

  def down
    add_column :transactions, :transaction_id, :integer
  end
end

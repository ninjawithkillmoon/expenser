class AddTransactionSettlementToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_settlement_id, :integer
  end
end

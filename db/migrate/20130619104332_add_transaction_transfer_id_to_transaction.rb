class AddTransactionTransferIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_transfer_id, :integer
  end
end

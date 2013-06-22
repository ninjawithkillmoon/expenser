class CreateTagsTransactionsTable < ActiveRecord::Migration
  def up
    create_table :tags_transactions, :id => false do |t|
        t.references :tag
        t.references :transaction
    end
  end

  def down
    drop_table :tags_transactions
  end
end

class AddContactIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :contact_id, :integer
  end
end

class AddTransferTagIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :transfer_tag_id, :integer
  end
end

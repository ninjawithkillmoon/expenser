class AddTagIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :tag_id, :integer
  end
end

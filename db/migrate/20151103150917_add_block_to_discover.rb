class AddBlockToDiscover < ActiveRecord::Migration
  def change
    add_column :discovers, :block, :boolean
    add_index :discovers, :block
  end
end

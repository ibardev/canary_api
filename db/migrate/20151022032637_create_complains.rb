class CreateComplains < ActiveRecord::Migration
  def change
    create_table :complains do |t|
      t.integer :source_id
      t.integer :dest_id
      t.integer :reason
      t.text :comment

      t.timestamps null: false
    end
    add_index :complains, :source_id
    add_index :complains, :dest_id
  end
end

class CreateDiscovers < ActiveRecord::Migration
  def change
    create_table :discovers do |t|
      t.references :discoverable, index: true, polymorphic: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

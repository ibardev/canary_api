class CreateUserCounts < ActiveRecord::Migration
  def change
    create_table :user_counts do |t|
      t.integer :like_index
      t.integer :follow_index
      t.integer :respond_index
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :sex
      t.string :nickname
      t.date :birth
      t.string :dest_province
      t.string :dest_city
      t.string :province
      t.string :city
      t.integer :contact_type
      t.string :contact

      t.timestamps null: false
    end
    add_index :user_infos, :sex
  end
end

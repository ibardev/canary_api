class CreateInviteDiscovers < ActiveRecord::Migration
  def change
    create_table :invite_discovers do |t|
      t.references :user, index: true, foreign_key: true
      t.date :begin_date
      t.date :end_date
      t.text :content

      t.timestamps null: false
    end
  end
end

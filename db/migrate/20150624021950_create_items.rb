class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.string :brand
      t.integer :daystoship
      t.string :size
      t.integer :quest_id
      t.integer :duke_id
      t.integer :squire_id

      t.timestamps null: false
    end
  end
end

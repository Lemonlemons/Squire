class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :squire_id
      t.integer :duke_id
      t.integer :quest_id
      t.integer :sentby

      t.timestamps null: false
    end
  end
end

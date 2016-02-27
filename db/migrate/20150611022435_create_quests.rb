class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :imagesrc
      t.integer :submissiontype
      t.integer :squire_id
      t.integer :duke_id
      t.boolean :is_accepted, default: false
      t.boolean :is_proposalsent, default: false
      t.boolean :is_proposalaccepted, default: false
      t.boolean :is_proofsubmitted, default: false
      t.boolean :is_completed, default: false
      t.integer :timesflagged, default: 0
      t.string :title
      t.text :description
      t.float :pricetosquire, default: 0
      t.float :totalprice, default: 0
      t.float :squirescut, default: 0
      t.float :platformfees, default: 0
      t.string :proof1
      t.string :proof2
      t.string :proof3
      t.text :revision

      t.timestamps null: false
    end
  end
end

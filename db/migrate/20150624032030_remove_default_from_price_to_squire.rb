class RemoveDefaultFromPriceToSquire < ActiveRecord::Migration
  def change
    add_column :dukes, :activequests, :integer, :default => 0
  end

  def up
    change_column :quests, :pricetosquire, :float, :default => nil
  end

  def down
    change_column :quests, :pricetosquire, :float, :default => 0
  end
end

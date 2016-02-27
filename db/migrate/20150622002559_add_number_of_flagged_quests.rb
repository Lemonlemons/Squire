class AddNumberOfFlaggedQuests < ActiveRecord::Migration
  def change
    add_column :dukes, :flagsreceived, :integer
  end
end

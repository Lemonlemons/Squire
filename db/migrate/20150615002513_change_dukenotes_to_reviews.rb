class ChangeDukenotesToReviews < ActiveRecord::Migration
  def change
    rename_column :dukes, :numberofnotes, :numberofreviews
  end
end

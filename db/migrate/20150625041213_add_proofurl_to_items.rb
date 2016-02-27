class AddProofurlToItems < ActiveRecord::Migration
  def change
    add_column :items, :proofimg, :string
  end
end

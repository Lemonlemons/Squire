class Item < ActiveRecord::Base
  mount_uploader :proofimg, PictureUploader
end

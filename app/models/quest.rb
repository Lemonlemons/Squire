class Quest < ActiveRecord::Base
  mount_uploader :proof1, PictureUploader
  mount_uploader :proof2, PictureUploader
  mount_uploader :proof3, PictureUploader
end

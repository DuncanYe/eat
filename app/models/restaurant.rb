class Restaurant < ApplicationRecord
  validates_presence_of :name, :tel
  mount_uploader :image, PhotoUploader

end

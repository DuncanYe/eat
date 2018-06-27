class Comment < ApplicationRecord
  validates_presence_of :content
  belongs_to :user, optional: true
  belongs_to :restaurant
end

class User < ApplicationRecord
  before_save :initialize_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def admin?
    self.role == "admin"
  end

  def initialize_name
    if self.name == '' || self.name == nil
      self.name = self.email.split('@').first
    end
  end

  mount_uploader :avatar, AvatarUploader
  # validates_presence_of :name

  has_many :comments, dependent: :destroy
  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurants

end

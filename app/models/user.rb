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

  def following?(user)
    self.followings.include?(user)
  end

  def is_friend?(user)
    self.friends.include?(user)
  end

  def all_friends
    (friends + invers_friends).uniq
  end

  mount_uploader :avatar, AvatarUploader
  # validates_presence_of :name

  has_many :comments, dependent: :destroy
  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :friendships, dependent: :destroy, class_name: "Friendship", foreign_key: "user_id"
  has_many :friends, through: :friendships

  has_many :invers_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :invers_friends, through: :invers_friendships, source: :user

end

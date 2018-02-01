class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :blogs
  has_many :pictures
  has_many :favorite_pictures, through: :favorites, source: :picture
  belongs_to :picture, optional: true
#  has_many :favorite_blogs, through: :favorites, source: :blog
#  belongs_to :blog, optional: true

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_save { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  mount_uploader :profile_image, ImageUploader
end

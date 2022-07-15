class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts
end

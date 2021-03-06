class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes

  def recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end
end

class Post < ApplicationRecord
  validates_presence_of :title
  validates :title, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User', foreign_key: :author_id, counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_posts_counter
    author.posts_counter = Post.where(author_id: author.id).size
  end

  def recent_comments
    Comment.includes(:author).where(post_id: id).order(created_at: :desc).limit(5)
  end
end

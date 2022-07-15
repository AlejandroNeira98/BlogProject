class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id, counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_posts_counter
    author.posts_counter = Post.where(author_id:).size
  end

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end
end

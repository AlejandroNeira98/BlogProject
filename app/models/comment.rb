class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, counter_cache: :comments_counter

  def update_comments_counter
    post.comments_counter = Comment.where(post_id:).size
  end
end

require 'rails_helper'

RSpec.describe Like, type: :model do
  first_user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')
  subject { Like.new(author: first_user, post: first_post) }

  it 'updates correctly' do
    subject.update_likes_counter
    count = Like.where(post_id: subject.post_id).size
    expect(subject.post.likes_counter).to eq(count)
  end
end

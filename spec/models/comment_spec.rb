require 'rails_helper'

RSpec.describe Comment, type: :model do
  first_user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  second_user = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')

  subject { Comment.new(post: first_post, author_id: second_user.id, text: 'Hi Tom!' ) }

  before { subject.save }

  it 'updates correctly' do
    subject.update_comments_counter
    count = Comment.where(post_id: subject.post_id).size
    expect(subject.post.comments_counter).to eq(count)
  end
end

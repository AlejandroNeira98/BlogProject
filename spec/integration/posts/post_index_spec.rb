require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:all) do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/Photo1', bio: 'Teacher from Mexico.',
                              post_counter: 0)
    first_post = Post.create(author_id: @first_user.id, title: 'Hello', text: 'This is my first post',
                             comments_counter: 0, likes_counter: 0)
    second_post = Post.create(author_id: @first_user.id, title: 'New', text: 'This is my new post',
                              comments_counter: 0, likes_counter: 0)
    third_post = Post.create(author_id: @first_user.id, title: 'Again', text: 'This is my again post',
                             comments_counter: 0, likes_counter: 0)
    fourth_post = Post.create(author_id: @first_user.id, title: 'Recent', text: 'This is my recent post',
                              comments_counter: 0, likes_counter: 0)
  end
end

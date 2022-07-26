require 'rails_helper'

RSpec.describe 'Post show page test', type: :feature do
  before :all do
    @first_user ||= User.create(
      name: 'Tom',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Mexico',
    )
    @second_user ||= User.create(
      name: 'Lilly',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Poland',
    )
    Post.create(author: @first_user, title: 'First Post', text: 'This is my first post')
    Post.create(author: @first_user, title: 'Second Post', text: 'This is my second post')
    Post.create(author: @first_user, title: 'Third Post', text: 'This is my third post')
    @post = Post.first
    Comment.create(author: @second_user, post: @post, text: 'Hi Tom!')
    Comment.create(author: @second_user, post: @post, text: 'Hi Tom! 2')
    @comment = Comment.first
    Like.create(author: @second_user, post: @post)
  end

  before :each do
    visit user_post_path(@first_user, @post)
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'I can see the post\'s title' do
    expect(page).to have_content(@post.title)
  end

  it 'I can see who wrote the post' do
    expect(page).to have_content("#{@post.title} by #{@post.author.name}")
  end

  it 'I can see how many comments it has' do
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'I can see the post\'s body' do
    expect(page).to have_content(@post.text)
  end

  it 'I can see the username of each commentor' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'I can see the comment each commentor left' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end

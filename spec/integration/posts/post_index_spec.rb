require 'rails_helper'

RSpec.describe 'Post index page test', type: :feature do
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
  end

  before :each do
    visit user_posts_path(@first_user)
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'I can see the user\'s profile picture' do
    expect(page.has_xpath?("//img[@src = '#{ @first_user.photo}' ]"))
  end

  it 'I can see the user\'s username' do
    expect(page.has_link?(@first_user.name)).to be true
  end

  it 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{@first_user.posts_counter}")
  end

  it 'I can see a post\'s title.' do
    expect(page).to have_content(@post.title)
  end

  it 'I can see some of the post\'s body.' do
    expect(page).to have_content(@post.text[0, 50])
  end

  it 'I can see the first comments on a post' do
    expect(page).to have_content(@comment.text)
  end

  it 'I can see how many comments a post has' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'I can see how many likes a post has' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'When click on a post, it redirects to that post\'s show page' do
    find_link(href: "/users/#{@first_user.id}/posts/#{@post.id}").click
    expect(page).to have_content(@post.title) && have_content(@post.text)
  end
end

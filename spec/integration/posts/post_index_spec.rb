require 'rails_helper'

RSpec.describe 'Post index page test', type: :feature do
  before :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    User.delete_all

    @first_user = User.new(
    id: 1,
      name: 'Tom',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Mexico',
      posts_counter: 0
    )
    @first_user.save

    @second_user = User.create(
      name: 'Lilly',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Poland',
      posts_counter: 0
    )
    @post = Post.create(author_id: @first_user.id, title: 'First Post', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
    Post.create(author_id: @first_user.id, title: 'Second Post', text: 'This is my second post', likes_counter: 0, comments_counter: 0)
    Post.create(author_id: @first_user.id, title: 'Third Post', text: 'This is my third post', likes_counter: 0, comments_counter: 0)

    @comment = Comment.create(id: 1, author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom!')
    Comment.create(id: 2, author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom! 2')
  end

  before :each do
    p @first_user
    visit user_posts_url(@first_user)
  end

  it 'I can see the user\'s profile picture' do
    expect(page.has_xpath?("//img[@src = '#{@first_user.photo}' ]"))
  end

  it 'I can see the user\'s username' do
    expect(page.has_link?(@first_user.name)).to be true
  end

  it 'I can see the number of posts the user has written' do
    @post.update_posts_counter
    expect(page).to have_content("Number of posts:#{@first_user.posts_counter}")
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

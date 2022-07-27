require 'rails_helper'

RSpec.describe 'User show page test', type: :feature do
  before :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    User.delete_all

    @first_user = User.new(
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
    @post = Post.create(id: 1, author_id: @first_user.id, title: 'First Post', text: 'This is my first post')
    Post.create(id: 2, author_id: @first_user.id, title: 'Second Post', text: 'This is my second post')
    Post.create(id: 3, author_id: @first_user.id, title: 'Third Post', text: 'This is my third post')

    @comment = Comment.create(id: 1, author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom!')
    Comment.create(id: 2, author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom! 2')
  end

  before :each do
    visit user_path(@first_user)
  end

  it 'I can see the user\'s profile picture' do
    expect(page.has_xpath?("//img[@src = '#{@first_user.photo}' ]"))
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content(@first_user.name.to_s)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content("Number of posts:#{@first_user.posts_counter}")
  end

  it 'I can see the user\'s bio.' do
    expect(page).to have_content(@first_user.bio)
  end

  it 'I can see the user\'s first 3 posts' do
    @first_user.recent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'I can see a button that lets me view all of a user\'s posts' do
    expect(page.has_link?('See all posts', href: "/users/#{@first_user.id}/posts")).to be true
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page' do
    find_link(href: "/users/#{@first_user.id}/posts/#{@post.id}").click
    expect(page).to have_content(@post.title)
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    find_link('See all posts', href: "/users/#{@first_user.id}/posts").click
    expect(page).to have_current_path("/users/#{@first_user.id}/posts")
  end
end

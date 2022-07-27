require 'rails_helper'

RSpec.describe 'User index page test', type: :feature do
  before :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    User.delete_all

    @first_user = User.create(
      name: 'Tom',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Mexico',
      posts_counter: 0
    )

    @second_user = User.create(
      name: 'Lilly',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Poland',
      posts_counter: 0
    )
    @post = Post.create(author_id: @first_user.id, title: 'First Post', text: 'This is my first post',
                        likes_counter: 0, comments_counter: 0)
    Post.create(author_id: @first_user.id, title: 'Second Post', text: 'This is my second post', likes_counter: 0,
                comments_counter: 0)
    Post.create(author_id: @first_user.id, title: 'Third Post', text: 'This is my third post', likes_counter: 0,
                comments_counter: 0)

    @comment = Comment.create(author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom!')
    Comment.create(author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom! 2')
  end

  before :each do
    visit users_path
    puts page.body
  end

  it 'I can see the username of all other users' do
    User.all.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'I can see the profile picture for each user' do
    User.all.each do |user|
      expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
    end
  end

  it 'I can see the number of posts each user has written.' do
    User.all.each do |user|
      expect(page).to have_content("Number of posts:#{user.posts_counter}")
    end
  end

  it 'When click on a user, is redirected to that user\'s show page' do
    find_link(@first_user.name).click
    expect(page).to have_current_path("/users/#{@first_user.id}")
  end
end

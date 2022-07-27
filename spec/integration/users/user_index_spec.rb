require 'rails_helper'

RSpec.describe 'User index page test', type: :feature do
  before :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    User.delete_all

    @first_user = User.create(
      id: 1,
      name: 'Tom',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Mexico'
    )
    @second_user = User.create(
      id: 2,
      name: 'Lilly',
      photo: 'https://scitechdaily.com/images/Human-Brain-Memories-Neurons.jpg',
      bio: 'A teacher from Poland'
    )
  end

  before :each do
    puts @first_user 
    visit users_path
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
    sleep(5)
    find_link(@first_user.name).click
    sleep(5)
    expect(page).to have_current_path("/users/#{@first_user.id}")
  end
end

require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
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
  end

  after :all do
    @first_user.destroy
    @second_user.destroy
  end

  before :each do
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
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'When click on a user, is redirected to that user\'s show page' do
    find_link(User.first.name).click
    expect(page).to have_current_path("/users/#{User.first.id}")
  end
end

require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  before(:all) do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/Photo1', bio: 'Teacher from Mexico.', posts_counter: 0)
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/Photo2', bio: 'Teacher from Poland.', posts_counter: 0)
  end

  after :all do
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end
end 

I can see the username of all other users.
I can see the profile picture for each user.
I can see the number of posts each user has written.
When I click on a user, I am redirected to that user's show page.
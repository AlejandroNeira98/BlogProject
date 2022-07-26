require 'rails_helper'

# user show page:

# I can see the user's profile picture.
# I can see the user's username.
# I can see the number of posts the user has written.
# I can see the user's bio.
# I can see the user's first 3 posts.
# I can see a button that lets me view all of a user's posts.
# When I click a user's post, it redirects me to that post's show page.
# When I click to see all posts, it redirects me to the user's post's index page.

RSpec.describe 'User index page', type: :system do
  before(:all) do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/Photo1', bio: 'Teacher from Mexico.',
                              post_counter: 0)
    @second_user = User.create(name: 'Lili', photo: 'https://unsplash.com/photos/Photo2', bio: 'Teacher from Poland.',
                               post_counter: 0)
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'returns 3 posts' do
    post_number = subject.recent_posts.length
    expect(post_number).to be <= 3
  end
end

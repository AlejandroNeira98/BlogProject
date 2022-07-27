require 'rails_helper'

RSpec.describe 'Post show page test', type: :feature do
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
    @post = Post.create(id: 1, author_id: @first_user.id, title: 'First Post', text: 'This is my first post')
    Post.create(id: 2, author_id: @first_user.id, title: 'Second Post', text: 'This is my second post')
    Post.create(id: 3, author_id: @first_user.id, title: 'Third Post', text: 'This is my third post')

    @comment = Comment.create(id: 1, author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom!')
    Comment.create(id: 2, author_id: @second_user.id, post_id: @post.id, text: 'Hi Tom! 2')
    Like.create(author_id: @second_user.id, post_id: @post.id)
  end

  before :each do
    visit user_post_path(@first_user, @post)
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

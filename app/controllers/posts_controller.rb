class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = @post.recent_comments
  end

  def new
    @user = current_user
  end

  def create
    @user = current_user
    post = Post.new(author_id: @user.id, title: params[:title], text: params[:text], comments_counter: 0,
                    likes_counter: 0)
    redirect_to user_posts_path(params[:user_id]) if post.save
  end
end

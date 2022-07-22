class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @user = Used.find(params[:user_id])
    @comments = Comment.where(post_id: @post.id)
  end
end

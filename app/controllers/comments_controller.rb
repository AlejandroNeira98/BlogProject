class CommentsController < ApplicationController
  def new; end

  def create
    @user = current_user
    if Comment.create(author_id: @user.id, post_id: params[:post_id], text: params[:text])
      redirect_to user_posts_path(params[:user_id])
    end
  end
end

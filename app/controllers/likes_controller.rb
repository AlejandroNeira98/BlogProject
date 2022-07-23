class LikesController < ApplicationController
  def create
    user = current_user
    like = Like.new(author_id: user.id, post_id: params[:like][:post_id])
    if like.save
      redirect_back(fallback_location: '/')
    else
      puts 'error'
    end
  end
end

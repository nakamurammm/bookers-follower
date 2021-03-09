class RelationshipsController < ApplicationController
  # before_action :set_user

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    relationship.destroy
    redirect_back(fallback_location: root_path)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.following_user
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

end

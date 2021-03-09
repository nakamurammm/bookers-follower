class RelationshipsController < ApplicationController
  # before_action :set_user

  def create
    current_user.follow(params[:format])
    redirect_to request.referer
  end

  def destroy
    relationship = current_user.unfollow(params[:id])
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

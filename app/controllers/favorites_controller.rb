class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    one_micropost = Micropost.find(params[:post_id])
    current_user.like(one_micropost)
    flash[:success] = '投稿をお気に入りに追加しました。'
    redirect_to root_url
  end

  def destroy
    one_micropost = Micropost.find(params[:post_id])
    current_user.unlike(one_micropost)
    flash[:success] = 'お気に入りから削除しました。'
    redirect_to root_url
  end
end

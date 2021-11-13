class FavoritesController < ApplicationController
  before_action :set_favorite

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
  end

  private

  def set_favorite
    @post = Post.find(params[:post_id])
  end
end

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "ご利用ありがとうございました"
  end

  def confirm
    @user = current_user
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def comments
    @user = User.find(params[:id])
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @comment_posts = Post.find(comments)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile, :profile_image)
  end
end

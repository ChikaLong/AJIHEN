class UsersController < ApplicationController
  before_action :set_user, except:[:confirm, :thanks]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to thanks_path
  end

  def confirm
    @user = current_user
  end

  def thanks
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def comments
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @comment_posts = Post.find(comments)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image)
  end
end

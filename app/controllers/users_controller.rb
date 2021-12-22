class UsersController < ApplicationController
  before_action :set_user, except: [:index, :confirm, :thanks]
  before_action :ensure_current_user, only: [:edit, :update]

  def index
    if user_signed_in? && current_user.admin?
      @users = User.page(params[:page]).per(15)
    else
      redirect_to root_path
    end
  end

  def show
    @posts = @user.posts.includes(:comments, :favorites).order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    if user_signed_in? && current_user.admin?
      redirect_to users_path
    else
      redirect_to thanks_path
    end
  end

  def confirm
    @user = current_user
  end

  def thanks
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.includes(:user, :comments, :favorites).order(created_at: :desc).find(favorites)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end

  def comments
    comments = Comment.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.includes(:user, :comments, :favorites).order(created_at: :desc).find(comments)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user
    unless user_signed_in? && current_user.id == @user.id
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image)
  end
end

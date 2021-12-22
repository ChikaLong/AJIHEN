class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def index
    # ソート機能用
    if params[:sort_create]
      @posts = Post.latest.includes(:user, :comments, :favorites).page(params[:page]).per(20)
    elsif params[:sort_rate]
      @posts = Post.rating.includes(:user, :comments, :favorites).page(params[:page]).per(20)
    elsif params[:sort_comment]
      @posts = Kaminari.paginate_array(Post.many).page(params[:page]).per(20)
    elsif params[:sort_favorite]
      @posts = Kaminari.paginate_array(Post.like).page(params[:page]).per(20)
    elsif params[:sort_high]
      @posts = Post.high.includes(:user, :comments, :favorites).page(params[:page]).per(20)
    else
      @posts = Post.includes(:user, :comments, :favorites).order(created_at: :desc).page(params[:page]).per(20)
    end
    # ランキング表示用
    @week_ranks = Post.week
    @month_ranks = Post.month
  end

  def show
    @user = @post.user
    @category = @post.category
    @comment = Comment.new
    @comments = @post.comments.includes(user: :comments).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
    @tags = Tag.all
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.score = Language.get_data(post_params[:review])
    if @post.save
      redirect_to post_path(@post), notice: '投稿に成功しました'
    else
      render :new
    end
  end

  def edit
    @tags = Tag.all
    @categories = Category.all
  end

  def update
    @post.score = Language.get_data(post_params[:review])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿内容を更新しました'
    else
      render :edit
    end
  end

  def destroy
    user = @post.user
    @post.destroy
    redirect_to user_path(user), notice: '投稿を削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_current_user
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(
      :image,
      :item_name,
      :review,
      :country,
      :place,
      :price,
      :rate,
      :category_id,
      { tag_ids: [] }
    )
  end
end

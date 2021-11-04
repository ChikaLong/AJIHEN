class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]

  def index
    if params[:sort_create]
      @posts = Post.latest.page(params[:page]).per(20)
    elsif params[:sort_rate]
      @posts = Post.rating.page(params[:page]).per(20)
    elsif params[:sort_comment]
      @posts = Kaminari.paginate_array(Post.many).page(params[:page]).per(20)
    elsif params[:sort_favorite]
      @posts = Kaminari.paginate_array(Post.like).page(params[:page]).per(20)
    else
      @posts = Post.page(params[:page]).per(20)
    end
    @today_ranks = Post.today
    @week_ranks = Post.week
    @month_ranks = Post.month
  end

  def show
    @user = @post.user
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @tags = Tag.all
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: 'レビューを投稿しました'
    else
      render :new
    end
  end

  def edit
    @tags = Tag.all
    @categories = Category.all
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'レビュー内容を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'レビューを削除しました'
  end

  private
  def set_post
     @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :item_name, :review, :country, :place, :price, :rate, :category_id, { tag_ids: [] })
  end
end

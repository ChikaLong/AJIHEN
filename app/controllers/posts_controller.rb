class PostsController < ApplicationController
  def index
    if params[:sort_create]
      # 新着順
      @posts = Post.latest.page(params[:page]).per(20)
    elsif params[:sort_rate]
      # 評価順
      @posts = Post.rating.page(params[:page]).per(20)
    elsif params[:sort_comment]
      # コメント数順
      @posts = Kaminari.paginate_array(Post.many).page(params[:page]).per(20)
    elsif params[:sort_favorite]
      # いいね数順
      @posts = Kaminari.paginate_array(Post.like).page(params[:page]).per(20)
    else
      @posts = Post.page(params[:page]).per(20)
    end
    @today_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_day).order('count(post_id) desc').limit(3).pluck(:post_id))
    @week_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').limit(3).pluck(:post_id))
    @month_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_month).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @tags = Tag.all
    @categories = Category.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'レビュー内容を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'レビューを削除しました'
  end

  private
  def post_params
    params.require(:post).permit(:image, :item_name, :review, :country, :place, :price, :rate, :category_id, { tag_ids: [] })
  end
end

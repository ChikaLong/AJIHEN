class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(20)
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

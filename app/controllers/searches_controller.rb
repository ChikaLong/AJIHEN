class SearchesController < ApplicationController
  before_action :set_rank

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).per(20)
  end

  def category_search
    @category = Category.find(params[:category_id])
    @posts = @category.posts.page(params[:page]).per(20)
  end

  def word_search
    @posts = Post.search(params[:keyword]).page(params[:page]).per(20)
    @keyword = params[:keyword]
  end

  private
  def set_rank
    @week_ranks = Post.week
    @month_ranks = Post.month
  end
end

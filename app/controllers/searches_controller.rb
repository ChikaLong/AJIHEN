class SearchesController < ApplicationController
  before_action :set_rank

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.includes(:user, :comments, :favorites).page(params[:page]).per(10)
  end

  def category_search
    @category = Category.find(params[:category_id])
    @posts = @category.posts.includes(:user, :comments, :favorites).page(params[:page]).per(10)
  end

  def word_search
    @keywords = params[:keyword]
    @posts = Post.includes(:user, :comments, :favorites).page(params[:page]).per(10)
    split_keywords = @keywords.split(/[[:blank:]]+/)
    split_keywords.each do |word|
      @posts = @posts.eager_load([:category, post_tags: :tag]).where([
        'item_name LIKE ? OR review LIKE ? OR country LIKE ? OR place LIKE ? OR categories.name LIKE ? OR tags.name LIKE ?',
        "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%",
      ])
    end
  end

  private

  def set_rank
    @week_ranks = Post.week
    @month_ranks = Post.month
  end
end

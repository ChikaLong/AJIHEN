class HomesController < ApplicationController
  layout 'about', only:[:about]

  def top
    @posts = Post.order("created_at desc").limit(5).includes(:user, :comments, :favorites)
    @categories = Category.all
    @tags = Tag.all
    @week_ranks = Post.week
    @month_ranks = Post.month
  end

  def about
  end
end

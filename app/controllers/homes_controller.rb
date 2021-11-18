class HomesController < ApplicationController
  def top
    @posts = Post.order("created_at desc").limit(3)
    @categories = Category.all
    @tags = Tag.all
    @week_ranks = Post.week
    @month_ranks = Post.month
  end

  def about
  end
end

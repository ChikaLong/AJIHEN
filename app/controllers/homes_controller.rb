class HomesController < ApplicationController
  def top
    @posts = Post.order("created_at desc").limit(3)
    @categories = Category.all
  end

  def about
  end
end

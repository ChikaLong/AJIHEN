class SearchesController < ApplicationController
  def tag_search
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  def category_search
    @category = Category.find(params[:category_id])
    @posts = @category.posts.all
  end
end

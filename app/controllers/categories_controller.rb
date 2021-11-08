class CategoriesController < ApplicationController
  before_action :if_not_admin, except:[:index]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "新規カテゴリを登録しました"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    @categories = Category.all
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "カテゴリを編集しました"
    else
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def if_not_admin
    redirect_to root_path unless (user_signed_in?) && current_user.admin?
  end
end

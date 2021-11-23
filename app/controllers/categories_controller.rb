class CategoriesController < ApplicationController
  before_action :if_not_admin, except: [:index]
  before_action :set_category

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "新規カテゴリを登録しました"
    else
      flash[:alert] = "カテゴリの登録に失敗しました"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "カテゴリを編集しました"
    else
      flash[:alert] = "カテゴリの編集に失敗しました"
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def if_not_admin
    if user_signed_in? && current_user.admin?
    else
      redirect_to root_path
    end
  end

  def set_category
    @categories = Category.all
  end
end

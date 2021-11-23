class TagsController < ApplicationController
  before_action :if_not_admin, except: [:index]
  before_action :set_tag

  def index
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "新規タグを登録しました"
    else
      flash[:alert] = "タグの登録に失敗しました"
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "タグを編集しました"
    else
      flash[:alert] = "タグの編集に失敗しました"
      render :edit
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def if_not_admin
    if user_signed_in? && current_user.admin?
    else
      redirect_to root_path
    end
  end

  def set_tag
    @tags = Tag.all
  end
end

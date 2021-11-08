class TagsController < ApplicationController
  before_action :if_not_admin, except:[:index]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "新規タグを登録しました"
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    @tags = Tag.all
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "タグを編集しました"
    else
      render :edit
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

  def if_not_admin
    redirect_to root_path unless (user_signed_in?) && current_user.admin?
  end
end

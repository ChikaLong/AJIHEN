class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(10)
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    if comment.save
      redirect_to post_path(@post)
    else
      flash[:alert] = "コメントが入力されていません"
      redirect_to post_path(@post)
    end
    # コメント通知用
    @post.create_notification_by(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(10)
    if current_user == @comment.user
      @comment.destroy
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

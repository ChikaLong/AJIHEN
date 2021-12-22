class NotificationsController < ApplicationController
  before_action :ensure_current_user

  def index
    @notifications = current_user.passive_notifications.includes(:visiter, :post).order(created_at: :desc).page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

  private

  def ensure_current_user
    unless user_signed_in?
      redirect_to root_path
    end
  end
end

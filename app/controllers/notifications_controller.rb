class NotificationsController < ApplicationController
  def clear
    Notification.not_viewed.where(user_id: current_user.id).update_all(visualized: true)

    redirect_to request.referrer
  end
end

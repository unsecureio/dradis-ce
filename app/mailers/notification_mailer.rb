class NotificationMailer < ApplicationMailer
  helper :avatar

  before_action :set_inline_attachments

  def digest
    @user = params[:user]
    @notifications = params[:notifications]
    @type = params[:type]

    mail to: @user.email, subject: 'You have unread notifications.'
  end

  private

  def find_asset(name)
    Rails.application.assets.find_asset(name).pathname
  end

  def set_inline_attachments
    attachments.inline['dradis_logo.png'] =
      if defined?(Dradis::Pro)
        File.read(find_asset('DradisPro_full_small.png'))
      else
        File.read(find_asset('DradisCE_full_small.png'))
      end
  end
end

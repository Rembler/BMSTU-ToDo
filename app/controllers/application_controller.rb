class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate, except: %i[new create] # :signup, :login,
  before_action :set_locale
  before_action :default_url_options

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  private

  def authenticate
    unless current_user
      redirect_to login_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end

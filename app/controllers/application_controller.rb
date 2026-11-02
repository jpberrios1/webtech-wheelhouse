class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :resume_session
  before_action :require_authentication

  after_action :verify_authorized, except: :index, raise: false
  after_action :verify_policy_scoped, only: :index, raise: false

 rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  helper_method :pundit_user

  def pundit_user
    Current.user
  end

  def user_not_authorized
    render "errors/forbidden", status: :forbidden, formats: [:html], content_type: "text/html"
  end

end

class PortalController < ApplicationController
  enable_authorization
  rescue_from CanCan::Unauthorized do |exception|
    redirect_to root_url, :error => t('auth.unauthorized')
  end
end
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_device_scope
    return :ios   if params.has_key?(:ios)
    return :ios2x if params.has_key?(:ios2x)
    return :ios3x if params.has_key?(:ios3x)
  end
end

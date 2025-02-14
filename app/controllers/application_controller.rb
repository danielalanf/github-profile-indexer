class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  add_flash_types :success, :info, :warning, :error, :question
  allow_browser versions: :modern
end

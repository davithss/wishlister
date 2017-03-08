class HomeController < ApplicationController
  skip_before_action :verify_current_user, only: :index

  def index; end
end

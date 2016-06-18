class AdminsController < ApplicationController

  before_filter :require_login, only: [:show]

  def show
    @admin = Admin.find(params[:id])

    if @admin.username == "taha.jalil" || @admin.username == "asad" || @admin.username == "zoheb" || @admin.username == "haris"
      @cities = City.order('name ASC')
    else
      @city = City.find_by(admin_id: Admin.find(@admin.id))
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:username, :password)
  end

  def not_authenticated
    redirect_to root_path, alert: "You do not have access to this page."
  end

end

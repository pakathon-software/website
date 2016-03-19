class ResourcesController < ApplicationController

  before_filter :find_admin, except: [:index]
  before_filter :find_resource, only: [:edit, :update, :destroy]

  def index
    @resources = Resource.order('created_at ASC')
    @hackathon_resources = Resource.order('created_at ASC').where(series: "Hackathon Resource")
    @email_course_resources = Resource.order('created_at ASC').where(series: "Email Course")
    @webinar_series_resources = Resource.order('created_at ASC').where(series: "Webinar Series")
    @fact_sheets_resources = Resource.order('created_at ASC').where(series: "Fact Sheets")
    @other_resources = Resource.order('created_at ASC').where(series: "Other")
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.admin_id = current_user.id

    if @resource.save
      redirect_to my_resources_admin_resources_path(current_user), notice: "Resource successfully added."
    else
      render :new, alert: "Unable to add resource. Please try again."
    end
  end

  def my_resources
    if current_user.username == "taha.jalil"
      @resources = Resource.all
    else
      @city = City.find_by_admin_id(@admin.id)
      @resources = @admin.resources.order('created_at ASC')
    end
  end

  def edit
  end

  def update
    if @resource.update_attributes(resource_params)
      redirect_to my_resources_admin_resources_path(current_user), notice: "Resource successfully edited."
    else
      render :edit, alert: "Unable to edit resource. Please try again."
    end
  end

  def destroy
    @resource.destroy
    redirect_to my_resources_admin_resources_path(current_user), notice: "Resource successfully deleted."
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :email_course_banner, :series, :type_of_document, :twitter_canned_message, :facebook_canned_message, :link_to_muut_discussion, :link_to_document, :link_to_download, :admin_id)
  end

  def find_admin
    @admin = Admin.find(current_user.id)
  end

  def find_resource
    @resource = Resource.find(params[:id])
  end
end

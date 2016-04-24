class CitiesController < ApplicationController

  before_filter :require_login, except: [:index, :show, :get_involved]
  before_filter :find_city, only: [:show, :edit, :update, :dashboard, :get_involved]
  before_filter :find_user, only: [:edit, :update, :destroy, :dashboard]

  def index
    @cities = City.order('eventbrite_page DESC')
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to admin_path(current_user), notice: "#{@city.name} successfully created!"
    else
      render :new, alert: "There was an issue creating this city. Please try again."
    end
  end

  def show
    @resources = Resource.order('created_at DESC').limit(4)
    @faqs = @city.faqs.order('created_at ASC').limit(3)
    @upcoming_events = @city.events.where('event_date >= ?', Date.today).order(:event_date)[0...2]
    @past_events = @city.events.where('event_date < ?', Date.today).order(:event_date)[0...3]
  end

  def edit
  end

  def update
    if @city.update_attributes(city_params)
      redirect_to admin_path(current_user), notice: "Successfully updated #{@city.name}!"
    else
      render :edit, alert: "There was an issue updating #{@city.name}'s details. Please try again."
    end
  end

  def destroy
  end

  def dashboard
    @core_team_members = @city.users.where(type_of_user: "Core Team Member");
    @team_members = @city.users.where(type_of_user: "Team Member");
    @city_leads = @city.users.where(type_of_user: "City Lead");
    @judges = @city.users.where(type_of_user: "Judge");
    @mentors = @city.users.where(type_of_user: "Mentor");
    @sponsors = @city.users.where(type_of_user: "Sponsor");
  end

  private

  def city_params
    params.require(:city).permit(:name, :hero_photo, :hero_photo_url, :hero_photographer_name, :hero_photographer_page, :hero_copy, :address, :email, :phone, :facebook, :twitter, :eventbrite_page, :map_photo, :province_name, :postal_code, :team_description)
  end

  def find_city
    @city = City.friendly.find(params[:id])
  end

  def find_user
    @admin = Admin.find(current_user.id)
  end

  def not_authenticated
    redirect_to root_path, alert: "You do not have access to this page."
  end

end

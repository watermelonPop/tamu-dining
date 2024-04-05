class AdministratorsController < ApplicationController
  before_action :set_administrator, only: %i[ show destroy ]

  # GET /administrators
  def index
    @administrators = Administrator.all

    render json: @administrators
  end

  # GET /administrators/1
  def show
    puts "EMAIL: " + params[:email]
    @administrator = Administrator.find_by(email: params[:email])
    
    if @administrator.nil?
      render json: { error: "Administrator not found", params: params }, status: :not_found
    else
      render json: @administrator
    end
  end

  # POST /administrators
  def create
    existing_admin = Administrator.find_by(email: administrator_params[:email])
    if existing_admin
      render json: { error: "email already exists in the database as an administrator" }, status: :unprocessable_entity
    else
      @administrator = Administrator.new(administrator_params)

      if @administrator.save
        render json: @administrator, status: :created, location: @administrator
      else
        render json: @administrator.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /administrators/1
  def destroy
    @administrator = Administrator.find_by(email: params[:email])
    @administrator.destroy!
  end

  def validate_admin
    @email = params[:administrator_email]
    @admin = Administrator.find_by(email: @email)
    if @admin != nil
      render json: true
    else
      render json: false
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find_by(email: params[:email])
    end

    # Only allow a list of trusted parameters through.
    def administrator_params
      params.require(:administrator).permit(:first_name, :last_name, :email)
    end
end

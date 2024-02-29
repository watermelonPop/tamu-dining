class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def show
    @user = User.find_by(uin: params[:uin])
  
    if @user.nil?
      render json: { error: "User not found", params: params }, status: :not_found
    else
      render json: @user
    end
  end

  # POST /users
  def create
    existing_user = User.find_by(uin: user_params[:uin])
    if existing_user
      render json: { error: "UIN already exists in the database" }, status: :unprocessable_entity
    else
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find_by(uin: params[:uin])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find_by(uin: params[:uin])
    @user.destroy!
  end

  def update_credits
    user = User.find_by(uin: params[:uin])
    credits = params[:credits].to_i
    if user
      user.update(credits: user.credits + credits)
      render json: { message: "Credits updated successfully" }
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(uin: params[:uin])
  
      if @user.nil?
        render json: { error: "User not found" }, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :uin, :email, :credits)
    end
end

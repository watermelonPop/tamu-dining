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
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:uin])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:uin])
    @user.destroy!
  end

  # Increase number of credits
  def increase_credits
    @user = User.find_by(uin: params[:uin])
    credits = params[:credits]

    # checks for invalid number of credits
    if credits < 0
      render json: {status: 'error', message: 'invalid number of credits', uin: @user.uin, credits: @user.credits}
    end

    @user.credits += credits
    render json: {status: 'success', message: 'increase user credits', uin: @user.uin, credits: @user.credits}
  end

  # Decrease number of credits
  def decrease_credits
    @user = User.find_by(uin: params[:uin])
    credits = params[:credits]

    # checks for invalid number of credits
    if credits < 0 or credits < @user.credits
      render json: {status: 'error', message: 'invalid number of credits', uin: @user.uin, credits: @user.credits}
    end
    
    @user.credits -= params[:credits]
    render json: {status: 'success', message: 'decreased user credits', uin: @user.uin, credits: @user.credits}
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

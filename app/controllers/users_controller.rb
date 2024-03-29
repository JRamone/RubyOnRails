class UsersController < ApplicationController
  include ActiveStorage::SetCurrent
  before_action :set_user, only: %i[show edit update destroy]

  def toggle_enabled
    user = User.find(params[:id])
    user.update_attribute :enabled, !user.enabled

    new_status = user.enabled? ? "Enabled" : "Disabled"

    redirect_to user, notice: "account status changed to #{new_status}"
  end

  # GET /users or /users.json
  def index
    @users = User.includes(:beers).all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.enabled = true
    @user.admin = false

    respond_to do |format|
      if @user.save
        format.html { redirect_to signin_path, notice: "Account successfully created, now sign in" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if user_params[:username].nil? && (@user == current_user) && @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    return unless @user == current_user

    @user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :avatar)
  end
end

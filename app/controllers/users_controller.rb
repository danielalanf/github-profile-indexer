class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy rescan]
  def index
    if params[:user_filter]
      @searched = true
      @filtro = UserFilter.new(params[:user_filter])
      respond_to do |format|
        format.html { @results = find_users }
      end
    else
      @filtro = UserFilter.new
      @results = []
    end
  end

  # GET /users/1
  def show; end

  # GET /users/1/edit
  def edit; end

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User was successfully created!"
      redirect_to @user
    else
      flash[:error] = "Failed to create user."
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if user_params.present? && @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # POST /users/1/rescan
  def rescan
    @user.rescanner

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully rescanned." }
      else
        format.html { redirect_to @user, alert: "Failed to rescan user." }
      end
    end
  end


  # DELETE /user/1
  def destroy
    if @user.destroy
      flash[:notice] = "User was successfully destroyed."
    else
      flash[:alert] = "Failed to delete user."
    end

    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end

  private

  def find_users
    return [] unless @filtro.valid?

    Elastic::UserSearchQuery.new(@filtro.params).search.results
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :github_url)
  end
end

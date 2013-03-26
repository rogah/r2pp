class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    if @user.save
      flash[:succcess] = "Welcome to R2 Production Planning!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  	@user = User.find(params[:id])
  end
end

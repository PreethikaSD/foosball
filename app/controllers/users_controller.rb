class UsersController < ApplicationController

  before_action :authorize_admin, only: [:create, :destroy, :new, :edit]

  def index
    @users = User.all
  end
 
  def show
    @user = User.find(params[:id])
  end
 
  def new
    @user = User.new
  end
 
  def edit
    @user = User.find(params[:id])
  end
 
  def create
    @user = User.new(user_params)
 
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
 
  def update
    @user = User.find(params[:id])
 
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
 
  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
    redirect_to users_path
  end
 
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation)
    end

    def authorize_admin
    	if signed_in?
	    	unless current_user.role == "admin" 
	    		redirect_to root_path, alert: "You don't have access. Please contact admin"
	    	end
	    else	
	    	redirect_to root_path, alert: "You don't have access. Please login as admin or contact admin"
	    end	
  	end

end

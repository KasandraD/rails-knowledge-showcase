class UsersController < ApplicationController

  def new
      @user = User.new
  end
  
  # def create
  #   @user = User.new user_params
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to root_path
  #   else
  #     render :new
  #   end
  # end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      puts "User Role: #{@user.role}" 
      redirect_to root_path
    else
      flash[:alert] = "Wrong email or password"
      render :new
    end
  end

  def show
     @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update(user_params)
      flash[:success] = "username/password successfully updated"
      redirect_to edit_user_path @user
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end  
  
  def change_password
    @user = User.find(params[:id])


  end
    
  
    private
  
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :id,
      :role,
      :password,
      :password_confirmation
    )
  end

  def password_params
    params.permit(:id, :password, :password_confirmation)
end

end
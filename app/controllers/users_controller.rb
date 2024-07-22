class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    
  
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to login_path, notice: 'User created successfully. Please log in.'
      else
        render :new, status: :unprocessable_entity  # Render the new view with the @user object containing errors
      end
    end
  
  
    def login
      if request.post?
        user = User.find_by(email: params[:email].to_s.downcase)
        if user && user.authenticate(params[:password])
          puts "Login Successfully"
          auth_token = JsonWebToken.encode({ user_id: user.id })
          cookies[:auth_token] = {
            value: auth_token,
            httponly: true, 
            expires: 1.hour.from_now
          }
          redirect_to '/articles', notice: 'Login successful'    
          else
          @user = User.new
          flash.now[:alert] = 'Invalid email/password combination'
          render :login, status: :unauthorized
        end
      else
        @user = User.new
        render :login
      end
    end
  
    def log_out
      cookies.delete(:auth_token)
      redirect_to login_path
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
  end
  
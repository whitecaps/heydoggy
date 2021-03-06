class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@registrations = @user.registrations
		@events_created = Event.upcoming.where(created_by: @user.name)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Thanks for signing up, #{@user.name}! You're gorgeous. I love it."
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: "Sweetness... Profile Successfully Updated"
		else
			render :edit
		end
		
		#experimenting with birthday validation - tackle later
		#if (user_params.include?(:gender))
		#	#(user_params & ["breed", "gender", "birthday", "favourite_toy", "favourite_pasttime", "reason_loved"]).present?
		#	if @user.update(user_params)
		#		redirect_to @user, notice: "Profile Successfully Updated!"
		#	else
		#		render :breed
		#	end
		#else
		#	if @user.update(user_params)
		#		redirect_to @user, notice: "Profile Successfully Updated!"
		#	else
		#		render :edit
		#	end
		#end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		redirect_to root_url, alert: "Parting is such sweet sorrow... Account successfully deleted"
	end

	def breed
		@user = User.find(params[:user_id])
	end

private

	def require_correct_user
    	@user = User.find(params[:id])
    	redirect_to root_url unless current_user?(@user)
  	end

	def user_params
		params.require(:user).permit(:display_email, :name, :email, :password, :password_confirmation, :image, :breed, :gender, :birthday, :favourite_toy, :favourite_pasttime, :reason_loved, :friends_character, :favourite_dog)
	end
end

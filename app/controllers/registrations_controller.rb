class RegistrationsController < ApplicationController
	before_action :require_signin
	before_action :set_event

	def index
		@registrations = @event.registrations
	end

	def new
		@registration = @event.registrations.new
	end

	def create
		@registration = @event.registrations.new
		@registration.user = current_user
		if already_registered?(@event)
			redirect_to @event, notice: "You're already registered!"
		elsif @registration.save
			redirect_to event_registrations_path(@event), notice: "Hey-yo! Registration Successful"
		else
			render :new
		end

	end

	def destroy
		@event.registrations.find_by(user_id: current_user.id).destroy
		redirect_to @event, notice: "*sniffle* That's cool. Successfully Unregistered"
	end

private

#def registration_params
#	params.require(:registration).permit()
#end

def set_event
	@event = Event.find(params[:event_id])
end



end



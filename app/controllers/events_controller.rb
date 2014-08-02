class EventsController < ApplicationController
	before_action :require_signin, except: [:index, :show]
	before_action :require_admin_or_creator, except: [:index, :show, :new, :create]

	def index
		@events = Event.upcoming
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			email_registrees_update
			redirect_to @event, notice: "Event Successfully Updated!"
		else
			render :edit
		end
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			@event.update(created_by: current_user.name)
			redirect_to @event, notice: "Event Successfully Created!"
		else
			render :new
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to events_path, notice: "Event Successfully Deleted!"
	end


private

def event_params
	params.require(:event).permit(:name, :description, :starts_at, :ends_at, :location)
end


end



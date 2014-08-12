module EventsHelper

def display_registrees(event)
	if event.registrations.count.blank? || event.registrations.count.zero?
		content_tag(:strong, 'No Doggies Yet!')
	else
		link_to(pluralize(event.registrations.count, 'Playpal'), event_registrations_path(@event))
	end
end

def email_registrees_update
end

def parse_same_latlong(latitude, longitude)
	if (Event.where(lat: latitude, long: longitude) > 1)
		return Event.where(lat: latitude, long: longitude)
	end
end




end
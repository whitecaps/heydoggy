class Event < ActiveRecord::Base
	has_many :registrations, dependent: :destroy

	validates :name, :location, presence: true 
	validates :description, length: {minimum: 5}
	

	def self.upcoming
		where("starts_at >= ?", 7.hours.ago).order("starts_at asc")
	end

end

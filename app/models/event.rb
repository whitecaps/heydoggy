class Event < ActiveRecord::Base
	has_many :registrations, dependent: :destroy

	validates :name, :location, presence: true 
	validates :description, length: {minimum: 5}
	validate :end_after_start
	validates :starts_at, :ends_at, :presence => true



	def self.upcoming
		where("starts_at >= ?", 7.hours.ago).order("starts_at asc")
	end

private

def end_after_start
  return if ends_at.blank? || starts_at.blank?
 
  if ends_at < starts_at
    errors.add(:ends_at, "must be after the start date") 
  end 
end

end

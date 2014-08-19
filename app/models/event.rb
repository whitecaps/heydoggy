class Event < ActiveRecord::Base
	has_many :registrations, dependent: :destroy

	validates :name, :location, presence: true 
	validates :description, length: {minimum: 5}
	validate :end_after_start
	validates :starts_at, :ends_at, :presence => true

	DOG_PARKS = {
		"Nelson Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/nelson-park-dog-park.aspx",
		"Stanley Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/stanley-park-dog-park.aspx",
		"Devonian Harbour Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/devonian-harbour-park-dog-park.aspx",
		"Emery Barnes Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/emery-barnes-park-dog-park.aspx",
		"Sunset Beach Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/sunset-beach-park-dog-park.aspx",
		"Coopers Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/coopers-park-dog-park.aspx",
		"Crab Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/crab-park-at-portside-dog-park.aspx",
		"Strathcona Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/strathcona-park-dog-park.aspx",
		"Charleson Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/charleson-park-dog-park.aspx",
		"Southeast False Creek Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/southeast-false-creek-park-dog-park.aspx",
		"Hadden Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/hadden-park-dog-park.aspx",
		"Spanish Bank Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/spanish-bank-beach-park-dog-park.aspx",
		"Locarno Beach Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/locarno-park-extension-dog-park.aspx",
		"Valdez Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/valdez-park-dog-park.aspx",
		"Balaclava Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/balaclava-park-dog-park.aspx",
		"Musqueam Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/musqueam-park-dog-park.aspx",
		"Dusty Greenwell Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/dusty-greenwell-park-dog-park.aspx",
		"Quilchena Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/quilchena-park-dog-park.aspx",
		"Oak Meadows Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/oak-meadows-park-dog-park.aspx",
		"Fraser River Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/fraser-river-park-dog-park.aspx",
		"Queen Elizabeth Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/queen-elizabeth-park-dog-park.aspx",
		"Nat Bailey Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/nat-bailey-stadium-dog-park.aspx",
		"Sunset Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/sunset-park-dog-park.aspx",
		"Kingcrest Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/kingscrest-park-dog-park.aspx",
		"Jones Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/jones-park-dog-park.aspx",
		"Tecumesh Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/tecumseh-park-dog-park.aspx",
		"Killarney Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/killarney-park-dog-park.aspx",
		"Sparwood Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/sparwood-park-dog-park.aspx",
		"John Hendry Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/john-hendry-trout-lake-park-dog-park.aspx",
		"Sunrise Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/sunrise-park-dog-park.aspx",
		"Falaise Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/falaise-park-dog-park.aspx",
		"New Brighton Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/new-brighton-park-dog-park.aspx",
		"Fraserview Golf Course Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/fraserview-golf-course-dog-park.aspx",
		"George Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/george-park-dog-park.aspx",
		"Everett Crowley Park Dog off-leash area" => "http://vancouver.ca/parks-recreation-culture/everett-crowley-park-dog-park"
	}

	def self.upcoming
		where("starts_at >= ?", 7.hours.ago).order("starts_at asc")
	end

private

def end_after_start
  return if ends_at.blank? || starts_at.blank?
 
  if ends_at < starts_at
    errors.add(:ends_at, "must be after the Starts at") 
  end 
end

end

class User < ActiveRecord::Base
  has_secure_password

  has_many :registrations, dependent: :destroy

  GENDER = ['Female', 'Male']
  FRIENDS_CHAR = ['Chandler', 'Joey', 'Monica', 'Phoebe', "Phoebe's evil twin", 'Rachel', 'Ross', "None of the above (Gunther)"]
  FAVE_DOG = ['Air Bud', 'Beethoven', 'Bolt', 'Chance', 'Cujo', 'Dug', 'Lassie', 'The Littlest Hobo', "Santa's Little Helper", 'Scooby', "Seymour (Futurama. You know the episode.)", 'Shadow', 'Toto', 'Odie']
  if Rails.env.production?
    has_attached_file :image,
      :storage => :s3,
      :url => ':s3_domain_url',
      :path => '/:class/:attachment/:id_partition/:style/:filename',
      :s3_credentials => {
        :bucket => ENV['AWS_BUCKET'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      },
      :styles => {
        :small => "400x400>",
        :thumb => "100x100>"
      }
    else
      has_attached_file :image,
        :url => "/system/users/images/000/000/018/small/:basename.:extension",
        :styles => {
          :small => "400x400>",
          :thumb => "100x100>"
        }

  end
 
  
  validates_attachment :image, 
  :content_type => { :content_type => ['image/jpeg', 'image/png']  },
  :size => { :less_than => 1.megabyte }
  
  validates :name, presence: true
  validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }

  #validate :birthday_valid  //tackle this later


  def self.authenticate(email, password)
  	user = User.find_by(email: email)
  	user && user.authenticate(password)
  end

#def birthday_valid
  #return if ends_at.blank? || starts_at.blank? //from tutorial
 
  #if birthday > DateTime.now.to_date
    #errors.add(:birthday, "can't be in the future")
  #end 
#end

end

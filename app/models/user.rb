class User < ActiveRecord::Base
  has_secure_password

  has_many :registrations, dependent: :destroy
  has_attached_file :image,
    :styles => { :medium => "x300", :thumb => "x100"},
    :default_url => ':s3_domain_url',
    :storage => :s3,
    :bucket => 'heydoggyimages_standard',
    :s3_credentials => S3_credentials
  
  validates_attachment :image, 
  :content_type => { :content_type => ['image/jpeg', 'image/png']  },
  :size => { :less_than => 1.megabyte }
  
  validates :name, presence: true
  validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }

  def self.authenticate(email, password)
  	user = User.find_by(email: email)
  	user && user.authenticate(password)
  end

end

class User < ActiveRecord::Base
  has_secure_password

  has_many :registrations, dependent: :destroy

  if Rails.env.production?
     has_attached_file :image,
   :storage => :s3,
   :url => ':s3_domain_url',
   :path => '/:class/:attachment/:id_partition/:style/:filename',
   
   :s3_credentials => {
     :bucket => ENV["heydoggyimages_standard"], 
     :access_key_id => ENV["AKIAJFGHKNLOQ2YIKRFA"],
     :secret_access_key => ENV["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"]
   }
    else
      has_attached_file :image
  end
 
  
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

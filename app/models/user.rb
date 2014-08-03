class User < ActiveRecord::Base
  has_secure_password

  has_many :registrations, dependent: :destroy
  has_attached_file :image,
    :s3_credentials => {
          access_key_id: 'AKIAJFGHKNLOQ2YIKRFA',
              secret_access_key: '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',
              bucket:            'heydoggyimages_standard'
          }
  
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

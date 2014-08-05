module UsersHelper
	def image_for(user)
  		if user.image.exists?
  			image = MiniMagick::Image.open(user.image.url)
  			image.resize "10x10"
  			image.format "jpg"
    		image_tag(image)
  		else
   			 image_tag('placeholder.jpg')
  		end
	end
end

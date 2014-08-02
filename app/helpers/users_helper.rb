module UsersHelper
	def image_for(user)
  		if user.image.exists?
    		image_tag(user.image.url)
  		else
   			 image_tag('placeholder.png')
  		end
	end
end

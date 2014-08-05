module RegistrationsHelper
	def image_for_thumb(user)
  		if user.image.exists?
    		image_tag(user.image.url(:thumb))
  		else
   			 image_tag('placeholder.jpg')
  		end
	end
end

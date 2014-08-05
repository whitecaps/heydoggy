module UsersHelper
	def image_for(user)
  		if user.image.exists?
    		image_tag(user.image.url(:small))
  		else
   			 image_tag('placeholder.jpg')
  		end
	end

	def image_for_thumb(user)
  		if user.image.exists?
    		image_tag(user.image.url(:thumb))
  		else
   			 image_tag('placeholder.jpg')
  		end
	end
end

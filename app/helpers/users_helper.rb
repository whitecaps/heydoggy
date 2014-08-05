module UsersHelper
	def image_for(user)
  		if user.image.exists?
    		image_tag(user.image.url(:small))
  		else
   			 image_tag('placeholder.jpg')
  		end
	end
end

module ApplicationHelper

  def image_for(user)
      if user.image.exists?
        image_tag(user.image.url(:small), :id => "profile-image")
      else
         image_tag('placeholder.jpg', :id => "profile-image")
      end
  end
	

end

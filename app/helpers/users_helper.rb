module UsersHelper
	def calc_age(user)
		#number_with_precision((DateTime.now.to_date - user.birthday)/365, precision: 2)
		diff = (DateTime.now.to_date - user.birthday)/365
		number_with_precision(diff, precision: 3, strip_insignificant_zeros: true)

	end
end

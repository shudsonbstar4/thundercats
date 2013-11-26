module OrdersHelper
	def pretty_address(customer)
		address = customer.address1
		if ! customer.address2.blank? #If the address2 line isn't blank, show it
			address += "<br />" + customer.address2
		end
		address += "<br />" + customer.city
		address += ", " + customer.state
		address += " " + customer.zip
		return address
	end
end

class Cart
	
	
	def self.calculate_cart_total(cart)
		@sum = 0
		cart.each do |key, value_array|
			@qty = value_array[0]
			@price = value_array[2]
			@total = @qty * @price
			@sum = @sum + @total
		end
		
		return @sum
	end
	
	
	def self.delete_cart_total(cart)
		product_id = params[:product_id]
		cart.each do |key, value_array|
			if key = product_id
				@sum = @sum - value_array[2]
				cart.delete(product_id)
			end
		end
		
	end
	
end
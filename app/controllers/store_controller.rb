class StoreController < ApplicationController

  def index
		category_name = params[:category_name]
		if category_name.blank? #If tag is blank, get all the products.
			@products = Product.all
		else
			@products = Category.find_by_name(category_name).products
			#@products = Category.find(category.id).products #Don't need the id at all
		end
	
		#OLD CODE
		
		#@categories = Category.all
		#@products = Product.all
		#@product_category = ProductCategory.all
		
		#if params[:id].blank?
			#@products = Product.order('name asc')
		#else
			#@categories = ProductCategory.where(:category_id => params[:id])
				#return category_id and the product_id
			#@products = []
			#@categories.each do |cat| #each cat is a hash w/ the product_id and category_id
				#parent_product = Product.where(:product_id => cat.product_id)
				#@products.push(parent_product)
				#parent_product = ProductCategory.where(:category_id => params[:id])#ProductCategory.where(:product_id => categories)
				#second loop through has to grab key/value pair
				#cat.each do |(item, key)|
					#if item == category_id
						#@products.push(key)
					#end
				#end
			#end
			
		#END OLD CODE
		#end
		if session[:cart].nil?
			session[:cart] = {} #Initialize empty hash if the cart is empty
		end
		
		Rails.logger.info "#{session[:cart]} WIERD"
		@cart = session[:cart]
		
		#calculating the cart total
		@sum = Cart.calculate_cart_total(@cart)
		#session.clear #clears cache
	end
	
	#<% @cart.each do |key, value| %>
					#<% current_quantity = value[0].to_i %>
					#<% current_price = value[2].to_f %>
					#<% item_price = current_quantity + current_price %>
					#<% @subtotal = @subtotal + item_price %>
	#<% end %>
	
	
	def add_cart
		@products = Product.all
		@product_id = params[:product_id].to_i
		@product_name = params[:product_name]
		@price = params[:price].to_f
		@quantity = params[:quantity].to_i #because params comes in as a string
		
		if session[:cart].nil?
			session[:cart] = {} #Initialize empty hash if the cart is empty
		end
		
		@current_cart = session[:cart] #pulling current_cart out and saving into variable
		
		Rails.logger.info "CART= #{session[:cart]} vs #{@current_cart}"
		
		if @current_cart[@product_id].nil? #If product_id is nil (undefined) then it will update cart with the product_id
			@current_cart[@product_id] = [@quantity, @product_name, @price]
		else
			@value_array = @current_cart[@product_id] #Saving previous array in new variable so won't be overwritten; this is selecting the key product_id and extracting the associated value, setting it to the value_array
			old_quantity = @value_array[0] #This is the index for the QUANTITY value and it is setting it to the old_quantity variable to save it
			new_quantity = old_quantity + @quantity #Taking the old_quantity value and adding it to quantity variable, which was passed in through the params
			@current_cart[@product_id] = [new_quantity, @product_name, @price] #old_quantity + quantity #Adding the old quantity with the new one and saving it to current_cart
			#This is taking the hash key product_id and setting the value to an array with the new_quantity variable, the product_name, and the price (not updating the price)
			
			#ADDED
			#old_total = value_array[0] * value_array[2]
		
		end
		

		@cart = @current_cart
		
		#Qty: 5 Price: 19.99
		#Qty: 2 Price: 4.99
		
		#@subtotal = 0
		#@cart.each do |key, value|
			#total = @current_cart[product_id][0] * @current_cart[@product_id][2]	#It's taking in the new quantity (which is reading it as line items instead of overall quantity) and multiplying it by the second price)
			#@subtotal = @subtotal + total
			#return @subtotal
		#end
		
		@sum = Cart.calculate_cart_total(@cart)
		
		Rails.logger.info "CART = #{session[:cart]}" #Puts out input to server log so you can debug and see what's being sent to server

	end

	
	def delete_cart
		
		Rails.logger.info "CART= #{session[:cart]} vs #{@current_cart}"

			#old_quantity = @value_array[0] #It's not passing in the values for this array
			#new_quantity = old_quantity - @quantity #Taking the old_quantity value and adding it to quantity variable, which was passed in through the params
			#@current_cart[@product_id] = [new_quantity, @product_name, @price] #old_quantity + quantity #Adding the old quantity with the new one and saving it to current_cart
			#This is taking the hash key product_id and setting the value to an array with the new_quantity variable, the product_name, and the price (not updating the price)

		#end
		

		@cart = @current_cart
		
		@sum = Cart.delete_cart_total(@cart)
		
		Rails.logger.info "CART = #{session[:cart]}" #Puts out input to server log so you can debug and see what's being sent to server
	
	end
	
end

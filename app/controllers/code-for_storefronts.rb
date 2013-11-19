  #1. Grab the Category record where the name is equal to what is passed in DONE
	#2. Find the Category ID associated with the name DONE
	#3. Go to the ProductCategory table and match the Category ID with a row and pull the product IDs of that row out DONE
	#4. Go to the Products table and match the Products associated with that Category (through the ProductCategory table) with the IDs that have been pulled out (loop w/ array)
			
	if params[:name].blank?
		@products = Product.order('name asc')
	else
		@categories = ProductCategory.where(:category_id => params[:id]) #Goes to DB & pulls out record where the Category name is equal to the params passed through the browser; stores in a variable
		#An array of products for that category	
		#Pull out array of hashes, and then go to Products table and pull out records associated with product id
		
		#@item = @categories[1] #grabbing the second element out of the array, which is the product_id
		#@products = Product.where(:id => @item) #going to products table and grabbing record where the id is the same
		
		#ADDED
		#product_category = ProductCategory.where(:category_id => category_id)
		#product_category = product_category.product_id
		#product_shown = Product.where(:product_id => product_category)
		#END ADDED
			
		@products = [] #Initialize an array
		@categories.each do |category| #For each category
			parent_product = ProductCategory.where(:product_id => categories) #Need to find the product associated with the category (the params of which were passed) and assign it to a variable
			@products.push(parent_product) #Push the parent product into the @products array, which will be looped through and printed on the index page (NOTE: Problem because links are in the application.html.erb instead of index.html.erb???)
		end
	end
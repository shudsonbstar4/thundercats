class StoreController < ApplicationController

  def index
		@categories = Category.all
		@products = Product.all
		@product_category = ProductCategory.all
		
		if params[:id].blank?
		@products = Product.order('name asc')
	else
		@categories = ProductCategory.where(:category_id => params[:id])
			#return category_id and the product_id
		@products = []
		@categories.each do |cat| #each cat is a hash w/ the product_id and category_id
			parent_product = Product.where(:product_id => cat.product_id)
			@products.push(parent_product)
			#parent_product = ProductCategory.where(:category_id => params[:id])#ProductCategory.where(:product_id => categories)
			#second loop through has to grab key/value pair
			#cat.each do |(item, key)|
				#if item == category_id
					#@products.push(key)
				#end
			#end
		end
	end
	
	
  end
	
	def add_cart
		@products = Product.all
	end
	
end

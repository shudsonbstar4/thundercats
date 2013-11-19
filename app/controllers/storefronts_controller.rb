class StorefrontsController < ApplicationController
  # GET /storefronts
  # GET /storefronts.json
  def index
    @storefronts = Storefront.all
		@categories = Category.all
		@products = Product.all
		@product_category = ProductCategory.all
			
	#1. Grab the Category record where the name is equal to what is passed in DONE
	#2. Find the Category ID associated with the name DONE
	#3. Go to the ProductCategory table and match the Category ID with a row and pull the product IDs of that row out DONE
	#4. Go to the Products table and match the Products associated with that Category (through the ProductCategory table) with the IDs that have been pulled out (loop w/ array)
	
	# 
			
	if params[:id].blank?
		@products = Product.order('name asc')
	else
		@categories = ProductCategory.where(:category_id => params[:id])
			#return category_id and the product_id
		@products = []
		@categories.each do |cat|
			cat.each do |item, key|
				if item == 'category_id'
				#parent_product = Product.where(:product_id => cat.product_id)
					@products.push(key)
			#parent_product = ProductCategory.where(:category_id => params[:id])#ProductCategory.where(:product_id => categories)
				end #end if
			end #End inner cat loop
		end
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @storefronts }
    end
  end

  # GET /storefronts/1
  # GET /storefronts/1.json
  def show
    @storefront = Storefront.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @storefront }
    end
  end

  # GET /storefronts/new
  # GET /storefronts/new.json
  def new
    @storefront = Storefront.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storefront }
    end
  end

  # GET /storefronts/1/edit
  def edit
    @storefront = Storefront.find(params[:id])
  end

  # POST /storefronts
  # POST /storefronts.json
  def create
    @storefront = Storefront.new(params[:storefront])

    respond_to do |format|
      if @storefront.save
        format.html { redirect_to @storefront, notice: 'Storefront was successfully created.' }
        format.json { render json: @storefront, status: :created, location: @storefront }
      else
        format.html { render action: "new" }
        format.json { render json: @storefront.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /storefronts/1
  # PUT /storefronts/1.json
  def update
    @storefront = Storefront.find(params[:id])

    respond_to do |format|
      if @storefront.update_attributes(params[:storefront])
        format.html { redirect_to @storefront, notice: 'Storefront was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @storefront.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storefronts/1
  # DELETE /storefronts/1.json
  def destroy
    @storefront = Storefront.find(params[:id])
    @storefront.destroy

    respond_to do |format|
      format.html { redirect_to storefronts_url }
      format.json { head :no_content }
    end
  end
end

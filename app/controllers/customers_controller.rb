class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
				#Create order/line items from cart; cart is a hash, with the key as the product_id and value is nested array
				current_cart = session[:cart] 
				order = Order.new
				order.customer_id = @customer.id
				sub_total = Cart.calculate_cart_total(current_cart) #Will give sub_total of all the items in the current cart
				
				order.sub_total = sub_total #We are building order object line by line
				order.sales_tax = sub_total * Order::CURRENT_SALES_TAX
				order.grand_total = order.sub_total + order.sales_tax
				
				order.save
				
				#Save each line item into DB in the LineItem table
				current_cart.each do |key, item| #Accessing the key and the value
					line_item = LineItem.new #Instanciating new line item object
					line_item.product_id = key
					line_item.quantity = item[0]
					#line_item.product_name = item[1] #NOT GOING TO WORK B/C NO PRODUCT_NAME IN LINEITEM TABLE
					line_item.unit_price = item[2]
					line_item.line_item_total = line_item.quantity * line_item.unit_price
					line_item.order_id = order.id
					
					line_item.save
				end
				
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end

class Order < ActiveRecord::Base
  attr_accessible :customer_id, :grand_total, :sales_tax, :sub_total
	belongs_to :customer
	has_many :line_items
	
	CURRENT_SALES_TAX = 0.06
	
	
	def self.sales_tax_in_percent
		return CURRENT_SALES_TAX * 100
	end
	
end

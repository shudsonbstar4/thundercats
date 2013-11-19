class Order < ActiveRecord::Base
  attr_accessible :customer_id, :grand_total, :sales_tax, :sub_total
	belongs_to :customer
	has_many :line_items
end

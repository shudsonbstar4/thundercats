class LineItem < ActiveRecord::Base
  attr_accessible :line_item_total, :order_id, :product_id, :quantity, :unit_price
	belongs_to :order
	belongs_to :product
end

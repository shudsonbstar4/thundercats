class ProductCategory < ActiveRecord::Base
  attr_accessible :category_id, :product_id
	belongs_to :product
	belongs_to :category
	
	validates_presence_of :product_id, :category_id
	validates_uniqueness_of :product_id, :scope => :category_id
end

class Storefront < ActiveRecord::Base
  attr_accessible :category_id, :product_id, :title
	has_many :categories
	has_many :products
end

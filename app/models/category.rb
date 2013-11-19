class Category < ActiveRecord::Base
  attr_accessible :name
	has_many :product_categories, :dependent => :destroy
	has_many :products, :through => :product_categories
	belongs_to :storefront
end

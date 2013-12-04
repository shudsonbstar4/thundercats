class Product < ActiveRecord::Base
	paginates_per 3
  attr_accessible :brand, :description, :model_num, :name, :quantity, :sku, :unit_price
	has_many :line_items
	has_many :product_categories, :dependent => :destroy
	has_many :categories, :through => :product_categories
	belongs_to :storefront
	
	validates_presence_of :name, :unit_price, :description, :quantity, :sku, :brand, :model_num
	validates :quantity, numericality: {only_integer: true}
	validates :model_num, numericality: {only_integer: true}
	validates :unit_price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0}
	validates :quantity, :numericality => {:greater_than => 0}
	validates :sku, uniqueness: true
	validates :description, length: { in: 2..500 }
	validates :name, length: { in: 3..50 }
end

class Customer < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :email, :name, :phone, :state, :zip
	has_one :order
	
	validates_presence_of :name, :email, :address1, :city, :state, :zip
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	validates :email, uniqueness: true
	validates :phone, length: { is: 10, message: "Please include your area code" }
	validates :state, length: { is: 2}
	validates :state, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
	validates :city, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
	validates :name, length: { in: 1..60 }
	validates :zip, length: {is: 5, message: "Please enter your 5 digit code"}
	
end

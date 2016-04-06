class Org < ActiveRecord::Base
  has_many :users
  has_many :quickbooks_customers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:stripe_connect, :quickbooks]
end

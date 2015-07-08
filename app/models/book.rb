class Book < ActiveRecord::Base
  has_many :checkout_histories
  has_many :users, through: :checkout_histories

  validates_presence_of :title, :author, :campus
end
class Book < ActiveRecord::Base
  has_many :users, through: :checkout_histories

  validates_presence_of :title, :author, :campus
end
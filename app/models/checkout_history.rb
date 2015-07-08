class CheckoutHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :user_id, :book_id, :due_date 
end

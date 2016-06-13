class Meal < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :order_id, uniqueness: {scope: :user_id}, presence: true
end

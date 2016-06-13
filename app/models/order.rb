class Order < ActiveRecord::Base
  belongs_to :user
  has_many :meals

  validates :name, presence: true

  module Status
    ORDERED   = 1
    DELIVERED = 2
    FINALIZED = 3
  end
end

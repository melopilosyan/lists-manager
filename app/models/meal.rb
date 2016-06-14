class Meal < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :order_id, uniqueness: {scope: :user_id}, presence: true

  def created_at_humanize
    self.created_at.to_formatted_s(:short)
  end
end

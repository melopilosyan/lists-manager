class Order < ActiveRecord::Base
  belongs_to :user
  has_many :meals

  validates :name, presence: true

  module Status
    ORDERED   = 1
    DELIVERED = 2
    FINALIZED = 3

    def self.to_s s
      case s
        when DELIVERED then 'Delivered'
        when FINALIZED then 'Finalized'
        else 'Ordered'
      end
    end

    def self.from_string status
      case status
        when 'Delivered' then DELIVERED
        when 'Finalized' then FINALIZED
        else ORDERED
      end
    end
  end

  def status_name
    Status.to_s self.status
  end

  def created_at_humanize
    self.created_at.to_formatted_s(:short)
  end
end


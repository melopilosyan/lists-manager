class Order < ActiveRecord::Base
  belongs_to :user
  has_many :meals

  validates :name, :user_id, presence: true

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

  scope :active, -> { includes(:meals, :user).where.not(status: Status::FINALIZED).order 'created_at desc' }
  scope :archived, -> { includes(:meals, :user).where(status: Status::FINALIZED).order 'created_at desc' }

  def status_name
    Status.to_s self.status
  end

  def allow_change_status?
    self.status != Status::FINALIZED
  end

  def created_at_humanize
    self.created_at.to_formatted_s(:short)
  end
end


class Order < ActiveRecord::Base
  belongs_to :user
  has_many :meals

  validates :name, presence: true

  module Status
    ORDERED   = 1
    DELIVERED = 2
    FINALIZED = 3

    def self.to_s s
      filter = self.constants.select{ |c| self.const_get(c) == s }
      filter.empty? && '' || filter.first.to_s.capitalize
    end
  end

  def status_name
    Status.to_s self.status
  end

  def created_at_humanize
    self.created_at.to_formatted_s(:short)
  end
end


class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :delete_all

  validates :name, :user_id, presence: true

  module State
    OPEN            = 'Open'
    ARCHIVED        = 'Archived'
    FINALIZED       = 'Finalized'
    CANT_UPDATE_MSG = 'Can\'t update state, List is archived.'

    def self.check(state)
      case state
        when FINALIZED, ARCHIVED then state
        else OPEN
      end
    end
  end

  scope :with_items_and_user, -> { includes(:items, :user) }
  scope :active, -> { with_items_and_user.where.not(state: State::ARCHIVED).order 'created_at desc' }
  scope :archived, -> { with_items_and_user.where(state: State::ARCHIVED).order 'created_at desc' }

  def allow_change_status?
    self.state != State::ARCHIVED
  end

  def created_at_humanize
    self.created_at.to_formatted_s(:short)
  end

  def not_open?
    self.state != State::OPEN
  end

  def update_with(attrs, not_open_msg)
    attrs || (return nil)
    attrs[:state] &&
        (!allow_change_status? && (return State::CANT_UPDATE_MSG) ||
            (self.state = State.check(attrs[:state]))) ||
        not_open? && (return not_open_msg)
    attrs[:name] && (self.name = attrs[:name])

    # return false if save succeed otherwise error message
    !save && errors.full_messages.first
  end
end


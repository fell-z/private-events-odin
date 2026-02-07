class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances

  def self.past
    where("date < ?", Time.now.midnight)
  end

  def self.upcoming
    where("date >= ?", Time.now.midnight)
  end
end

class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, dependent: :destroy

  scope :past, -> { where("date < ?", Time.now.midnight) }
  scope :upcoming, -> { where("date >= ?", Time.now.midnight) }

  enum :status, { public: 0, private: 1 }, default: :private, suffix: true
end

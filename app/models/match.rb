class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: 'Club'
  belongs_to :away_team, class_name: 'Club'

  validates :home_team, presence: true
  validates :away_team, presence: true

  scope :upcoming, -> { where('kick_off > ?', Time.now - 3.hours).order(:kick_off) }

  def next_match?
    Match.upcoming.first.id == id
  end
end

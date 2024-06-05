class TournamentRecord < ApplicationRecord
  belongs_to :tournament
  has_many :teams
  has_many :games

  validates :name, :started_at, :ended_at, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "started_at", "ended_at"]
  end
end

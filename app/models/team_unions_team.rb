class TeamUnionsTeam < ApplicationRecord
  belongs_to :union_team
  belongs_to :team

  validates :union_team_id, presence: true
  validates :team_id, presence: true
end

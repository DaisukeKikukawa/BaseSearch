class UnionTeam < ApplicationRecord
  attr_accessor :team_ids_param

  has_many :team_unions_teams, dependent: :destroy
  has_many :teams, through: :team_unions_teams
  has_many :games, as: :home_teamable, class_name: "Game"
  has_many :games, as: :away_teamable, class_name: "Game"

  accepts_nested_attributes_for :team_unions_teams, allow_destroy: true

  validates :name, presence: true
  validate :must_have_at_least_one_team
  validate :must_not_have_duplicate_teams

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'name', 'created_at', 'updated_at']
  end

  def must_have_at_least_one_team
    if team_ids_param.blank? || team_ids_param.reject(&:blank?).empty?
      errors.add(:base, '少なくとも1つのチームを選択してください')
    end
  end

  def must_not_have_duplicate_teams
    team_ids = team_ids_param.reject(&:blank?)
    if team_ids.uniq.length != team_ids.length
      errors.add(:base, '異なるチームを選択してください')
    end
  end
end

class Game < ApplicationRecord
  belongs_to :ground
  belongs_to :tournament_record
  has_many :game_articles, dependent: :destroy
  belongs_to :home_teamable, polymorphic: true
  belongs_to :away_teamable, polymorphic: true, optional: true

  def home_team
    home_teamable
  end

  def away_team
    away_teamable
  end

  validates :start_time, presence: true
  validate :different_teams
  validate :both_scores_present_or_absent
  validate :away_team_input_validation

  enum tag_type: {
    no_tag: 0,
    featured: 1,
    final: 2,
    semi_final: 3,
    live: 4,
    movie: 5,
  }

  scope :upcoming, -> { where('start_time > ?', Time.current) }
  scope :live, -> { where('start_time <= ? AND ? < start_time + INTERVAL 2 HOUR', Time.current, Time.current) }
  scope :finished, -> { where('start_time + INTERVAL 2 HOUR <= ?', Time.current) }
  scope :from_team, ->(team_id) {
    where("(home_teamable_id = :team_id AND home_teamable_type = 'Team') OR
          (away_teamable_id = :team_id AND away_teamable_type = 'Team')", team_id:)
  }

  def self.ransackable_attributes(auth_object = nil)
    [
      "id", "home_team_id", "away_team_id", "away_team_name", "ground_id",
      "tournament_record_id", "start_time", "tag_type",
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["away_team", "game_articles", "ground", "home_team", "tournament_record"]
  end

  private

  def different_teams
    if home_teamable_id.present? && away_teamable_id.present? && home_teamable_id == away_teamable_id && home_teamable_type == away_teamable_type
      errors.add(:base, "主催側と対戦相手は、異なる必要があります")
    end
  end

  def both_scores_present_or_absent
    if home_team_score.nil? ^ away_team_score.nil?
      errors.add(:base, "両チームの得点が入力されているか、両チームの得点が入力されていないかのどちらかでなければなりません")
    end
  end

  def away_team_input_validation
    if away_teamable_id.present? && away_team_name.present?
      errors.add(:base, "市内チームと市外チーム両方を登録することはできません")
    elsif away_teamable_id.blank? && away_team_name.blank?
      errors.add(:base, "市内チームと市外チームのどちらか一方を入力する必要があります。")
    end
  end
end

class Team < ApplicationRecord
  belongs_to :team_category
  has_many :tournament_records
  has_many :players
  has_many :team_unions_teams
  # WpArticle モデルとの関連付け
  has_many :article_teams
  has_many :wp_articles, through: :article_teams
  # Slug モデルとの関連付け
  has_many :team_slugs, dependent: :destroy
  has_many :slugs, through: :team_slugs
  has_many :union_teams, through: :team_unions_teams
  has_many :games, as: :home_teamable, class_name: "Game"
  has_many :games, as: :away_teamable, class_name: "Game"

  has_one_attached :team_image
  has_one_attached :team_icon
  has_one_attached :team_logo
  has_one_attached :team_uniform

  validates :name, presence: true

  validate :validate_images

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "team_category_id", "school_name", "representative_name",
      "coach_name", "activity_base", "activity_day",]
  end

  private

  def validate_images
    validate_image_format_and_size(:team_image)
    validate_image_format_and_size(:team_icon)
    validate_image_format_and_size(:team_logo)
    validate_image_format_and_size(:team_uniform)
  end

  def validate_image_format_and_size(image_key)
    image = send(image_key)
    return unless image.attached?

    unless image.blob.content_type.in?(['image/png', 'image/jpg', 'image/jpeg'])
      errors.add(image_key, 'はPNG、JPG、JPEG形式でなければなりません。')
    end

    if image.blob.byte_size > 5.megabytes
      errors.add(image_key, 'のサイズは5MB以下でなければなりません。')
    end
  end
end

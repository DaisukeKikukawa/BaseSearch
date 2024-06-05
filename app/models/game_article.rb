class GameArticle < ApplicationRecord
  belongs_to :game
  has_one :article, as: :belongable, dependent: :destroy

  validates :article_type, uniqueness: { scope: :game_id, message: "は既に同じ試合で使用されています" }
  validate :article_content_presence

  enum article_type: {
    match_results: 0,
    highlights: 1,
  }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "article_type", "created_at", "updated_at", "game_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["article", "game"]
  end

  private

  def article_content_presence
    if article && (article.title.blank? || article.content.blank?)
      errors.add(:base, "タイトルとコンテンツは必須です")
    end
  end
end

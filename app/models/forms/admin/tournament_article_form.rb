class Forms::Admin::TournamentArticleForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_accessor :name , :title, :content

  validates :name, presence: true
  validates :title, presence: true

  validate :content_must_be_present

  def initialize(tournament: nil, params: {})
    @tournament = tournament
    set_attributes if @tournament.present?
    super(params)
  end

  def save
    return nil if invalid?

    ActiveRecord::Base.transaction do
      @tournament ||= Tournament.new(name:)
      article = @tournament.build_article(title:, content:)
      @tournament.save!
      return @tournament
    end
  end

  def update
    return nil if invalid?
    return unless @tournament.present?

    ActiveRecord::Base.transaction do
      @tournament.update(name:)
      @tournament.article.update(title:, content:)
      return @tournament
    end
  end

  private

  def set_attributes
    @name = @tournament.name
    @title = @tournament.article.title
    @content = @tournament.article.content
  end

  def content_must_be_present
    stripped_content = ActionView::Base.full_sanitizer.sanitize(content || "").gsub("&nbsp;", " ").strip
    if stripped_content.blank?
      errors.add(:content, 'を入力してください')
    end
  end
end

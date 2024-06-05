class Article < ApplicationRecord
  has_rich_text :content
  belongs_to :belongable, polymorphic: true

  validates :title, :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end
end

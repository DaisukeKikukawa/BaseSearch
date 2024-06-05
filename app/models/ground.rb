class Ground < ApplicationRecord
  has_many :games

  has_one_attached :image

  validates :name, :address, :sport, presence: true
  validates :tel, format: { with: /\A\d{0,11}\z/ }
  validates :link_url, :google_map_url, format: { with: /\Ahttps?:\/\/\S+\z/ }, allow_blank: true
  validate :image_format, :image_size

  enum :is_public, { published: true, not_published: false }, validate: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "address", "sport", "administrative_organization", "tel"]
  end

  private

  def image_format
    return unless image.attached?

    unless image.blob.content_type.in?(['image/png', 'image/jpg', 'image/jpeg'])
      errors.add(:image, 'はPNG、JPG、JPEG形式でなければなりません。')
    end
  end

  def image_size
    return unless image.attached?

    if image.blob.byte_size > 5.megabytes
      errors.add(:image, 'のサイズは5MB以下でなければなりません。')
    end
  end
end

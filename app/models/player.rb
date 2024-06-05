class Player < ApplicationRecord
  belongs_to :team

  validates :name, :kana, :position, :handedness, :handedness_bat, :alma_mater, presence: true
  validate :validate_images
  validate :validate_sub_positions

  has_one_attached :player_image
  has_one_attached :uniform_image

  enum position: { pitcher: 101, catcher: 201, first_baseman: 301,
                    second_baseman: 302, third_baseman: 303, shortstop: 304,
                    left_fielder: 401, center_fielder: 402, right_fielder: 403,
                    representative: 501, coach: 502,
                  }
  enum handedness: { right: 0, left: 1, switch: 2 }
  enum handedness_bat: { right_bat: 0, left_bat: 1, switch_bat: 2 }
  enum birth_date_visibility: { hidden: false, visible: true }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "kana", "team_id", "position", "alma_mater", "handedness", "handedness_bat"]
  end

  scope :infielders, -> { where(position: infield_positions) }
  scope :outfielders, -> { where(position: outfield_positions) }
  scope :pitchers, -> { where(position: positions[:pitcher]) }
  scope :catchers, -> { where(position: positions[:catcher]) }
  scope :etc, -> { where(position: etc_positions) }

  def birth_date_visible?
    birth_date_visibility == 'visible'
  end

  private

  def self.infield_positions
    positions.values_at(:first_baseman, :second_baseman, :third_baseman, :shortstop)
  end

  def self.outfield_positions
    positions.values_at(:left_fielder, :center_fielder, :right_fielder)
  end

  def self.etc_positions
    positions.values_at(:representative, :coach)
  end

  def validate_images
    validate_image_format_and_size(:player_image)
    validate_image_format_and_size(:uniform_image)
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

  def validate_sub_positions
    return if sub_positions == nil || sub_positions.length == 1
    sub_positions = JSON.parse(self.sub_positions.gsub('nil', 'null'))

    sub_positions.each do |sub_position|
      errors.add(:sub_positions, 'を設定しない場合は「設定しない」のみにしてください') if sub_position == nil
    end

    unless sub_positions.length == sub_positions.uniq.length
      errors.add(:sub_positions, 'で重複したポジションが設定されています。')
    end
  end
end

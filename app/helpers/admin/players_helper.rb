module Admin::PlayersHelper
  require 'json'

  def display_sub_positions(sub_positions, translate = true)
    sub_positions = JSON.parse(sub_positions.gsub('nil', 'null'))
    sub_positions.map do |sub_position|
      if translate
        I18n.t("activerecord.attributes.player.positions.#{Player.positions.key(sub_position)}")
      else
        Player.positions.key(sub_position)
      end
    end
  end
end

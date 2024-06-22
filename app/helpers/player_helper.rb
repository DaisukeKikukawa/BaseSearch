module PlayerHelper
  def display_age_or_school_year(birthday, reference_date = Date.today)
    age = calculate_age(birthday, reference_date)

    if age.between?(6, 18)
      calculate_school_year(birthday.year, birthday.month, reference_date.year, reference_date.month)
    else
      "#{age}歳"
    end
  end

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

  def display_birth_date_and_age(player)
    if player.birth_date_visible?
      "#{player.birth_date.strftime('%Y年%-m月')}生 (#{display_age_or_school_year(player.birth_date)})"
    else
      display_age_or_school_year(player.birth_date).to_s
    end
  end

  private

  def calculate_age(birthday, reference_date)
    age = reference_date.year - birthday.year -
          (birthday.to_date.change(year: reference_date.year) > reference_date ? 1 : 0)
    age += 1 if birthday.month <= 4 && birthday.day <= 1
    age
  end

  def calculate_school_year(birth_year, birth_month, judge_year, judge_month)
    judge_year -= 1 if judge_month < 4
    birth_year -= 1 if birth_month < 4
    year = judge_year - birth_year

    case year
    when 7..12
      "小学#{year - 6}年生"
    when 13..15
      "中学#{year - 12}年生"
    when 16..18
      "高校#{year - 15}年生"
    else
      "#{year}歳"
    end
  end
end

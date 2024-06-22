module ApplicationHelper
  include Pagy::Frontend

  # テキストを指定の長さで折り返し、省略記号を付けた形式で返します。
  #
  # @param text [String] 折り返しと省略記号を付ける対象のテキスト
  # @param wrap_length [Integer] 折り返しの長さ
  # @param max_length [Integer] 省略記号を付ける最大の長さ
  # @return [String] 折り返しと省略記号を付けたテキスト
  def wrap_and_ellipsizing_text(text, wrap_length, max_length)
    if max_length != nil
      substring_name = text[0, max_length]
    else
      substring_name = text
    end
    if wrap_length != nil
      format_text = substring_name.scan(/.{1,#{wrap_length}}/).join("</span><br><span>")
    else
      format_text = substring_name
    end
    if max_length == nil || substring_name.length == text.length
      "<span>#{format_text}</span>"
    else
      "<span>#{format_text}...</span>"
    end
  end

  def default_meta_tags
    {
      description: "野球が盛んなまち『球都桐生』の野球チーム情報、選手情報、大会・試合情報、球場情報などをまとめて掲載。カテゴリーを超えて様々な球都桐生のリアルタイム野球情報を得ることができます。",
      og: {
        image: image_url("ogp.jpg"),
        title: "桐生野球チームナビ",
        description: "野球が盛んなまち『球都桐生』の野球チーム情報、選手情報、大会・試合情報、球場情報などをまとめて掲載。カテゴリーを超えて様々な球都桐生のリアルタイム野球情報を得ることができます。",
        url: request.original_url,
      },
      twitter: {
        card: 'summary',
      },
      noindex: !Rails.env.production?,
    }
  end
end

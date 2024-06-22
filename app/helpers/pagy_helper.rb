module PagyHelper
  include Pagy::Frontend
  def pagy_nav_custom(pagy)
    html = +%(<nav class="pagy-nav" role="navigation" aria-label="pagination">)

    # 最初のページへのリンク
    if pagy.page > 1
      html << %(<span class="first">#{pagy_link_proc(pagy).call(1, '«', 'aria-label="first"')}</span>)
    end

    # 前のページへのリンク
    if pagy.prev
      html << %(<span class="prev">#{pagy_link_proc(pagy).call(pagy.prev, '‹', 'aria-label="previous"')}</span>)
    end

    # ページ番号のリンク
    pagy.series.each do |item|
      html << if item.is_a?(Integer)
                %(<span class="page">#{pagy_link_proc(pagy).call(item)}</span>)
              else
                %(<span class="page current">#{item}</span>)
              end
    end

    # 次のページへのリンク
    if pagy.next
      html << %(<span class="next">#{pagy_link_proc(pagy).call(pagy.next, '›', 'aria-label="next"')}</span>)
    end

    # 最後のページへのリンク
    if pagy.page < pagy.last
      html << %(<span class="last">#{pagy_link_proc(pagy).call(pagy.last, '»', 'aria-label="last"')}</span>)
    end

    html << %(</nav>)
    html.html_safe
  end
end

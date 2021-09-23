module MetaHelper
  def page_title(page_title = '')
    base_title = 'Fledge Hub'

    page_title.empty? ? base_title : "#{page_title} - #{base_title}"
  end

  def description(text = '')
    text.presence || '個人開発者のための、技術を検索できる開発サービス投稿サイト'
  end

  def meta_image_url(image_url = '')
    image_url.presence || 'https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg'
  end
end

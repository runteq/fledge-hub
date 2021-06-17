module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Fledge Hub'

    page_title.empty? ? base_title : "#{page_title} - #{base_title}"
  end

  def description(text = '')
    text.presence || 'サービスの説明'
  end

  def meta_image_url(image_url = '')
    image_url.presence || 'デフォルトのOGP用URL'
  end
end

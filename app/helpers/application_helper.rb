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

  def embedded_svg(filename, options = {})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    svg['class'] = options[:class] if options[:class].present?
    content_tag(doc.to_html.delete_prefix('<').chop)
  end
end

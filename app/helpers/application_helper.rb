module ApplicationHelper
  def link_to_blank(text, url)
    URI.parse(url)
    link_to text, sanitize(url), target: :_blank, rel: 'noopener noreferrer'
  end

  def page_title(page_title = '')
    base_title = 'RUNTEQ senses'

    page_title.empty? ? base_title : page_title + ' - ' + base_title
  end
end

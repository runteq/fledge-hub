module ApplicationHelper
  def link_to_blank(text, url)
    URI.parse(url)
    link_to text, sanitize(url), target: :_blank, rel: 'noopener noreferrer'
  end
end

module LinkHelper
  def link_to_blank(text, url, args = {})
    URI.parse(url)
    link_to text, sanitize(url), target: :_blank, rel: 'noopener noreferrer', **args
  end
end

module LinkHelper
  def link_to_blank(text, url)
    URI.parse(url)
    link_to text, sanitize(url), target: :_blank, rel: 'noopener noreferrer'
  end

  def link_to_active(user)
    user.deactivated? ? user.display_name : link_to(user.display_name, user_path(user.screen_name))
  end
end

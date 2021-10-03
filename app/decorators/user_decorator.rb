# frozen_string_literal: true

module UserDecorator
  def to_meta_tags
    {
      title: display_name,
      description: "#{display_name}のユーザーページ",
      og: {
        title: :full_title,
        image: url_for(avatar),
      },
      twitter: {
        title: :full_title,
        image: url_for(avatar),
      },
    }
  end
end

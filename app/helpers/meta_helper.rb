module MetaHelper
  # rubocop:disable Metrics/MethodLength, Layout/LineLength
  def default_meta_tags
    {
      site: 'Fledge Hub',
      reverse: true,
      charset: 'utf-8',
      description: '個人開発者のための 技術を検索できる開発サービス投稿サイト',
      keywords: '個人開発,駆け出しエンジニア',
      canonical: request.original_url,
      separator: ' - ',
      icon: [
        { href: "#{root_url}favicon.ico" },
        { href: "#{root_url}apple-touch-icon.png", rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: "#{root_url}ogp.png",
        locale: 'ja_JP',
      },
      twitter: {
        site_name: :site,
        title: :title,
        description: :description,
        card: 'summary_large_image',
        site: '@fledge-hub',
        image: "#{root_url}ogp.png",
      },
    }
  end
  # rubocop:enable Metrics/MethodLength, Layout/LineLength
end

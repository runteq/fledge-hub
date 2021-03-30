class Technology < ActiveHash::Base
  # バックエンド 1〜50
  # フロント 51〜100
  # インフラ 101〜150
  # 外部APIなど 151〜
  self.data = [
    { id: 1,
      display_name: 'Ruby',
      slug: 'ruby'
    },
    { id: 2,
      display_name: 'Ruby on Rails',
      slug: 'ruby-on-rails'
    },
    {
      id: 51,
      display_name: 'JavaScript',
      slug: 'javascript'
    },
    {
      id: 52,
      display_name: 'Vue.js',
      slug: 'vue-js'
    },
    {
      id: 53,
      display_name: 'React',
      slug: 'react'
    },
    {
      id: 101,
      display_name: 'AWS',
      slug: 'aws'
    },
    {
      id: 102,
      display_name: 'heroku',
      slug: 'heroku'
    },
    {
      id: 151,
      display_name: 'TwitterAPI',
      slug: 'twitter-api'
    },
  ]
end

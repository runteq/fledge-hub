product_hashes = (1..20).map do |n|
  {
    id: n,
    title: "いい感じのサービス#{n}",
    summary: "革新的・革命的なサービス！\n圧倒的な素晴らしさにきっとあなたは涙する……。",
    released_on: n.months.ago,
    url: 'https://runteq.jp/',
    source_url: 'https://github.com/runteq/fledge-hub',
    product_type_id: 1,
    product_category_id: 1
  }
end

Product.seed(:id, *product_hashes)

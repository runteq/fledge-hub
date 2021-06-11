hashes = (1..20).map do |n|
  {
    id: n,
    title: 'RUNTEQ Blog',
    url: 'https://blog.runteq.jp/',
    description: '',
    product_id: n
  }
end

Medium.seed(:id, *hashes)

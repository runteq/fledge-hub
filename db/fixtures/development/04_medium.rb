hashes = (1..20).map do |n|
  {
    id: n,
    title: 'RUNTEQ Blog',
    url: 'https://blog.runteq.jp/',
    product_id: n
  }
end

ProductMedium.seed(:id, *hashes)

hashes = (1..20).map do |n|
  {
    id: n,
    user_id: n,
    product_id: n
  }
end

UserProduct.seed(:id, *hashes)

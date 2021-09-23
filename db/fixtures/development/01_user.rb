user_hashes = (1..20).map do |n|
  {
    id: n,
    display_name: "example#{n}",
    screen_name: "example#{n}",
    email: "example#{n}@example.com",
    study_started_on: Time.current,
    status: :general
  }
end

User.seed(:id, *user_hashes)

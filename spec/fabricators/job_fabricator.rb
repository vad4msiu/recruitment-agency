Fabricator(:job) do
  title { Faker::Name.title }
  salary { rand(10_000) }
  expired_at { Faker::Date.forward(1.month) }
  contacts do
    [
      Faker::PhoneNumber.cell_phone,
      Faker::Internet.email,
      [
        Faker::Address.city,
        Faker::Address.street_address,
        Faker::Address.secondary_address
      ].join(", ")
    ].join("\n")
  end
end

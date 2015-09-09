Fabricator(:employee) do
  name do
    [
      Faker::Name.first_name,
      Faker::Name.last_name,
      Faker::Name.last_name
    ].join(" ").to_cyr.gsub(/[^а-я ]+/i, "").titleize
  end
  salary { rand(10_000) }
  status { Employee::AVAILABLE_STATUSES.sample }
  contacts { [Faker::Internet.email, Faker::PhoneNumber.cell_phone].sample }
end

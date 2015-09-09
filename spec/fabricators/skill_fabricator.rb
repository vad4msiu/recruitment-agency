Fabricator(:skill) do
  title {
    [
      Faker::Hacker.noun, Faker::Hacker.abbreviation,
      Faker::Hacker.ingverb, rand(1000)
    ].join(" ")
  }
end

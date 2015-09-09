# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

skills = 50.times.map do
  title = [Faker::Hacker.noun, Faker::Hacker.abbreviation].join(" ")
  while Skill.exists?(title: title)
    title = Faker::Hacker.noun
  end
  Skill.create(title: title)
end

100.times do
  name = [
    Faker::Name.first_name,
    Faker::Name.last_name,
    Faker::Name.last_name
  ].join(" ").to_cyr.gsub(/[^а-я ]+/i, "").titleize

  employee = Employee.create!(
    name:     name,
    salary:   rand(10_000),
    status:   Employee::AVAILABLE_STATUSES.sample,
    contacts: [Faker::Internet.email, Faker::PhoneNumber.cell_phone].sample
  )

  employee.update(skills: skills.sample(rand(30)))
end

100.times do
  job = Job.create!(
    title:      Faker::Name.title,
    salary:     rand(10_000),
    expired_at: Faker::Date.forward(1.month),
    contacts:   [
      Faker::PhoneNumber.cell_phone, Faker::Internet.email,
      [Faker::Address.city, Faker::Address.street_address, Faker::Address.secondary_address].join(", ")
    ].join("\n")
  )
  job.update(skills: skills.sample(rand(10)))
end
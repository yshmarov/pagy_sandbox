50.times do
  Event.create(artist: Faker::Artist.name, start: Faker::Time.between(from: 10.days.ago, to: 10.days.from_now))
end

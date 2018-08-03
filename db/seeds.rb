user1 = User.create! name: "TMD",
                     email: "a@a.a",
                     password: "asdasd",
                     user_type: 1,
                     activated: true,
                     activated_at: Time.zone.now
user2 = User.create! name: "Trieu Minh Duc0",
                     email: "b@b.b",
                     password: "asdasd",
                     user_type: 0,
                     activated: true,
                     activated_at: Time.zone.now
user3 = User.create! name: "Trieu Minh Duc1",
                     email: "c@b.b",
                     password: "asdasd",
                     user_type: 0,
                     activated: true,
                     activated_at: Time.zone.now
user4 = User.create! name: "Trieu Minh Duc2",
                     email: "d@b.b",
                     password: "asdasd",
                     user_type: 0,
                     activated: true,
                     activated_at: Time.zone.now
user5 = User.create! name: "Trieu Minh Duc3",
                     email: "r@b.b",
                     password: "asdasd",
                     user_type: 0,
                     activated: true,
                     activated_at: Time.zone.now

movie = Movie.create! title: "Wall-E",
  cast: Faker::Name.name + ", " + Faker::Name.name + ", " + Faker::Name.name,
  director: Faker::Name.name,
  description: Faker::Lorem.sentence(10),
  duration: Faker::Number.between(60, 150),
  rated: 0,
  language: "Eng",
  genre: "Animation | Adventure | Family | Sci-Fi",
  release_date: Time.current.tomorrow
movie2 = Movie.create! title: "World wall Z",
  cast: Faker::Name.name + ", " + Faker::Name.name + ", " + Faker::Name.name,
  director: Faker::Name.name,
  description: Faker::Lorem.sentence(10),
  duration: Faker::Number.between(60, 150),
  rated: 1,
  language: "Eng",
  genre: "Action | Adventure | Horror | Sci-Fi | Thriller",
  release_date: Time.current.tomorrow

1000.times do |n|
  title = Faker::Lorem.sentence 5
    Movie.create! title: "#{n} - #{title}",
    cast: Faker::Name.name + ", " + Faker::Name.name + ", " + Faker::Name.name,
    director: Faker::Name.name,
    description: Faker::Lorem.sentence(10),
    duration: Faker::Number.between(60, 150),
    rated: Faker::Number.between(0, 3),
    language: "Eng",
    genre: "Action | Adventure | Horror | Sci-Fi | Thriller",
    release_date: Time.current.tomorrow
end

room1 = Room.create! name: "G1",
                    seat_no: 50

room2 = Room.create! name: "G2",
                    seat_no: 50
seat = nil
room.seat_no.times do |n|
  seat = room.seats.create! row: (n/10+1), number: (n%10+1)
end

room2 = Room.create! name: "G2",
                    seat_no: 50

room2.seat_no.times do |n|
  seat2 = room2.seats.create! row: (n/10+1), number: (n%10+1)
end

seat = room.seats.create!

screening = movie.screenings.create! room_id: room.id

order = user1.orders.create! screening_id: screening.id

ticket = order.movie_tickets.create! seat_id: seat.id

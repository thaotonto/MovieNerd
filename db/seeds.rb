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

image_data = Rails.root.join("public/uploads/movie/picture/1/wall_e.jpeg").open
movie = Movie.create! title: "Wall-E",
  cast: Faker::Name.name + ", " + Faker::Name.name + ", " + Faker::Name.name,
  director: Faker::Name.name,
  description: Faker::Lorem.sentence(10),
  duration: Faker::Number.between(60, 150),
  rated: 0,
  language: "Eng",
  genre: "Animation | Adventure | Family | Sci-Fi",
  release_date: Time.current.tomorrow,
  picture: image_data
movie2 = Movie.create! title: "World wall Z",
  cast: Faker::Name.name + ", " + Faker::Name.name + ", " + Faker::Name.name,
  director: Faker::Name.name,
  description: Faker::Lorem.sentence(10),
  duration: Faker::Number.between(60, 150),
  rated: 1,
  language: "Eng",
  genre: "Action | Adventure | Horror | Sci-Fi | Thriller",
  release_date: Time.current.tomorrow,
  picture: image_data

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
    release_date: Time.current.tomorrow,
    picture: image_data
end

room1 = Room.create! name: "G1",
                    seat_no: 30

seat = nil
room1.seat_no.times do |n|
  next if (n/10+1 == 1 && n%10+1 == 3)
  next if (n/10+1 == 2 && n%10+1 == 1)
  next if (n/10+1 == 3 && n%10+1 == 2)
  seat = room1.seats.create! row: (n/6+1), number: (n%6+1)
end

room2 = Room.create! name: "G2",
                    seat_no: 50

seat2 = nil
room2.seat_no.times do |n|
  seat2 = room2.seats.create! row: (n/10+1), number: (n%10+1)
end

screening = movie.screenings.create! room_id: room1.id,
                                     screening_start: Time.current.tomorrow

order = user1.orders.create! screening_id: screening.id
order2 = user2.orders.create! screening_id: screening.id

seat_id = rand(1..room1.seat_no - 2)
order.movie_tickets.create! seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)
order.movie_tickets.create seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)
order.movie_tickets.create seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)
order.movie_tickets.create seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)
order.movie_tickets.create seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)

order2.movie_tickets.create seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)
order2.movie_tickets.create seat_id: seat_id
seat_id = rand(1..room1.seat_no - 2)
order2.movie_tickets.create seat_id: seat_id

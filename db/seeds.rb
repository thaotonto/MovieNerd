user1 = User.create! name: "TMD",
                     email: "a@a.a",
                     password: "asdasd"
user1.skip_confirmation!
user1.admin!
user1.save
user2 = User.create! name: "Trieu Minh Duc0",
                     email: "b@b.b",
                     password: "asdasd"
user2.skip_confirmation!
user2.save
user3 = User.create! name: "Trieu Minh Duc1",
                     email: "c@c.c",
                     password: "asdasd"
user3.skip_confirmation!
user3.save
user4 = User.create! name: "Trieu Minh Duc2",
                     email: "d@d.d",
                     password: "asdasd"
user4.skip_confirmation!
user4.save
user5 = User.create! name: "Trieu Minh Duc3",
                     email: "e@e.e",
                     password: "asdasd"
user5.skip_confirmation!
user5.save
user6 = User.create! name: "Trieu Minh Duc3",
                     email: "f@f.f",
                     password: "asdasd"
user6.skip_confirmation!
user6.save
user7 = User.create! name: "Trieu Minh Duc3",
                     email: "g@g.g",
                     password: "asdasd"
user7.skip_confirmation!
user7.save
user8 = User.create! name: "Trieu Minh Duc3",
                     email: "h@h.h",
                     password: "asdasd"
user8.skip_confirmation!
user8.save
user9 = User.create! name: "Trieu Minh Duc3",
                     email: "i@i.i",
                     password: "asdasd"
user9.skip_confirmation!
user9.save

image_data = Rails.root.join("app/assets/images/default-movie.jpg").open
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

30.times do |n|
  title = Faker::Lorem.sentence 4
    Movie.create! title: "#{n} - #{title}",
    cast: Faker::Name.name + ", " + Faker::Name.name + ", " + Faker::Name.name,
    director: Faker::Name.name,
    description: Faker::Lorem.sentence(10),
    duration: Faker::Number.between(60, 150),
    rated: Faker::Number.between(0, 3),
    language: "Eng",
    genre: "Action | Adventure | Horror | Sci-Fi",
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
room1.update_attributes seat_no: room1.seats.count

room2 = Room.create! name: "G2", seat_no: 50
seat2 = nil
room2.seat_no.times do |n|
  seat2 = room2.seats.create! row: (n/10+1), number: (n%10+1)
end
room2.update_attributes seat_no: room2.seats.count

20.times do |i|
  roomN = Room.create! name: "A#{i}", seat_no: 50
  roomN.seat_no.times do |n|
    roomN.seats.create! row: (n/10+1), number: (n%10+1)
  end
  roomN.update_attributes seat_no: roomN.seats.count
end

screening = movie.screenings.create! room_id: room1.id,
                                     screening_start: Time.current.tomorrow
movie.screenings.create! room_id: room1.id,
                         screening_start: Time.current.tomorrow + 3.hours
movie.screenings.create! room_id: room2.id,
                         screening_start: Time.current.tomorrow + 6.hours
movie.screenings.create! room_id: room1.id,
                         screening_start: Time.current.tomorrow + 10.hours
movie.screenings.create! room_id: room2.id,
                         screening_start: Time.current.tomorrow + 15.hours
movie.screenings.create! room_id: room1.id,
                         screening_start: Time.current.tomorrow + 21.hours
screening2 = movie.screenings.create! room_id: room2.id,
                         screening_start: Time.current.tomorrow + 30.hours

order = user1.orders.create! screening_id: screening.id, paid: 0
order2 = user2.orders.create! screening_id: screening.id, paid: 1
user2.orders.create! screening_id: screening.id, paid: 1
user2.orders.create! screening_id: screening.id, paid: 1

20.times do |i|
  user1.orders.create! screening_id: screening2.id, paid: 0
end

seat_id = 2
order.movie_tickets.create! seat_id: seat_id, screening_id: order.screening.id
seat_id = 3
order.movie_tickets.create seat_id: seat_id, screening_id: order.screening.id
seat_id = 5
order.movie_tickets.create seat_id: seat_id, screening_id: order.screening.id
seat_id = 7
order.movie_tickets.create seat_id: seat_id, screening_id: order.screening.id
seat_id = 11
order.movie_tickets.create seat_id: seat_id, screening_id: order.screening.id
seat_id = 14

order2.movie_tickets.create seat_id: seat_id, screening_id: order2.screening.id
seat_id = 24
order2.movie_tickets.create seat_id: seat_id, screening_id: order2.screening.id
seat_id = 21
order2.movie_tickets.create seat_id: seat_id, screening_id: order2.screening.id

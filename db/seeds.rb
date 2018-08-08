user1 = User.create! name: "TMD",
                     email: "a@a.a",
                     password: "asdasd",
                     user_type: 1,
                     activated: true,
                     activated_at: Time.zone.now

user2 = User.create! name: "Trieu Minh Duc",
                     email: "b@b.b",
                     password: "asdasd",
                     user_type: 0

movie = Movie.create! title: "Wall-E",
                      duration: 115
movie2 = Movie.create! title: "World wall Z",
                      duration: 115

1000.times do |n|
  title = Faker::Lorem.sentence 5
  Movie.create! title: "#{n} - #{title}",
                duration: 90
end

room = Room.create! name: "G1",
                    seat_no: 50

seat = room.seats.create!

screening = movie.screenings.create! room_id: room.id

order = user1.orders.create! screening_id: screening.id

ticket = order.movie_tickets.create! seat_id: seat.id

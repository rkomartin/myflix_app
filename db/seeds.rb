# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

genre = Genre.create(category: "Comedy")
genre2 = Genre.create(category: "Drama")
video = Video.create(title: "Monk", description: "Monk is Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", genre_id: 1)
video2 = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", genre_id: 1)
video3 = Video.create(title: "Futurama", description: "I have no clue what this is about", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", genre_id: 2)
video4 = Video.create(title: "South Park", description: "Quite likely, one of the craziest cartoons ever", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", genre_id: 1)

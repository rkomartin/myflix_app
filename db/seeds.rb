# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedy = Genre.create(category: "Comedy")
drama = Genre.create(category: "Drama")
video1 = Video.create(title: "Monk", description: "Monk is Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
video2 = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
video3 = Video.create(title: "Futurama", description: "I have no clue what this is about", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: drama)
video4 = Video.create(title: "South Park", description: "Quite likely, one of the craziest cartoons ever", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
video5 = Video.create(title: "Monk", description: "Monk is Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
video6 = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
video7 = Video.create(title: "Futurama", description: "I have no clue what this is about", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: drama)
video8 = Video.create(title: "South Park", description: "Quite likely, one of the craziest cartoons ever", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
video9 = Video.create(title: "South Park", description: "Quite likely, one of the craziest cartoons ever", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg", genre: comedy)
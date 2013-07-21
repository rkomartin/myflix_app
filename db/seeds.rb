# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedy = Genre.create(category: "Comedy")
drama = Genre.create(category: "Drama")

video1 = Video.create(title: "Monk", description: "Monk is Monk", small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")), genre: comedy)
video2 = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover: File.open(File.join(Rails.root, "/public/tmp/family_guy.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")), genre: drama)
video3 = Video.create(title: "Futurama", description: "I have no clue what this is about", small_cover: File.open(File.join(Rails.root, "/public/tmp/futurama.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")), genre: drama)
video4 = Video.create(title: "South Park", description: "Quite likely, one of the craziest cartoons ever", small_cover: File.open(File.join(Rails.root, "/public/tmp/south_park.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")), genre: comedy)

ioana = User.create(full_name: "Ioana Komartin", password: "parola", email: "ioana@example.com", admin: true)
ioana.update_column(:token, SecureRandom.urlsafe_base64)

review1 = Review.create(user: ioana, video: video1, rating: 5, content: "WOOOOW!")
review2 = Review.create(user: ioana, video: video1, rating: 3, content: "So so")

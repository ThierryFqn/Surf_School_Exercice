# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "nokogiri"
require "faker"
require "open-uri"

puts 'Destroy all Bookings'
Booking.destroy_all
puts 'Destroy all Courses'
Course.destroy_all
puts 'Destroy all Schools'
School.destroy_all
puts 'Destroy All Users'
User.destroy_all

teachers = []

puts 'Création des Teachers'

5.times do
  user = User.create!(
    username: Faker::FunnyName.name,
    email: Faker::Internet.email,
    teacher: true,
    password: "123456"
  )
  teachers << user
end

def assign_photo(record, url)
  file = URI.open(url)
  record.photo.attach(io: file, filename: "logo#{record}", content_type: 'image/png')
  record.save!
  puts 'Photo ajoutée'
end

def assign_logo(record, url)
  file = URI.open(url)
  record.logo.attach(io: file, filename: "logo#{record}", content_type: 'image/png')
  record.save!
  puts 'Logo ajoutée'
end

assign_photo(teachers[0], "https://avatars.githubusercontent.com/meligateau")
assign_photo(teachers[1], "https://avatars.githubusercontent.com/u/30435844?v=4")
assign_photo(teachers[2], "https://avatars.githubusercontent.com/u/90208637?v=4")
assign_photo(teachers[3], "https://avatars.githubusercontent.com/u/94071485?v=4")
assign_photo(teachers[4], "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1544604383/pnqv3gmdpbtqrstpqgls.jpg")


def assign_photo_courses(event, urls)
  urls.each do |url|
    file = URI.open(url)
    event.photos.attach(io: file, filename: "logo#{event}", content_type: 'image/png')
    event.save!
    puts 'Image ajouté event'
  end
end

# Création d'un user

user_1 = User.new(username: 'TFonq', email: 'thierry.fonquernie@gmail.com', password: "123456")
assign_photo(user_1, "https://avatars.githubusercontent.com/u/90208637?v=4")

# Creation Schools

puts "Creating Schools..."

puts 'create first school'
school_1 = School.new(name: 'Surf in Biarritz', address: "Plateau de l'Atalaye, 64200 Biarritz", user: teachers[0])
assign_photo(school_1, "https://www.surfinbiarritz.com/wp-content/uploads/2020/03/LOGO-FOND-BLANC.png")
assign_logo(school_1, "https://tabagisme.unisante.ch/wp-content/uploads/2019/09/test.jpg")
puts "Create #{school_1.name}"
school_2 = School.new(name: 'SAMA-SAMA', address: "18 avenue Beaurivage à Biarritz, 64200 Biarritz", user: teachers[1])
assign_photo(school_2, "https://ecoledesurfmimizan.fr/wp-content/uploads/2021/04/sama-logo-proper-v2.png")
puts "Create #{school_2.name}"
school_3 = School.new(name: 'Ecole française de Surf', address: "10 Rue du Port-Vieux, 64200 Biarritz", user: teachers[2])
assign_photo(school_3, "https://www.surfingfrance.com/images/000-Articles/2020T1/logos_label20-04.jpg")
puts "Create #{school_3.name}"
school_4 = School.new(name: 'Jo Moraiz', address: "Biscarosse", user: teachers[3])
assign_photo(school_4, "https://www.jomoraiz.com/wp-content/uploads/2018/01/logo-jomoraiz-2016-300x300.png")
puts "Create #{school_4.name}"
school_5 = School.new(name: 'Ocean Beach', address: "30 Av. de la Milady, 64200 Biarritz", user: teachers[4])
assign_photo(school_5, "https://oceanbeach.fr/wp-content/uploads/2018/04/logo.png")
puts "Create #{school_5.name}"

puts "Creating Courses..."

cours_1 = Course.new(sport: Course::SPORT_TYPES[0], description: 'Prenez des cours de Kite sur Biarritz',  school: school_1, daily_price: rand(100..200).round)
assign_photo_courses(cours_1, ["https://www.luxairtours.lu/sites/default/files/styles/paragraph_2_column/public/content/202107/KITESURF-MAN-600x315-medium-teaser-image.jpg?itok=D_ach5tr"])
puts "Create #{cours_1.sport}"

cours_2 = Course.new(sport: Course::SPORT_TYPES[1], description: 'Prenez des cours de Surf sur Biarritz',  school: school_2, daily_price: rand(100..200).round)
assign_photo_courses(cours_2, ["https://www.1jour1actu.com/wp-content/uploads/2021/06/VIDEO_surf.jpg"])
puts "Create #{cours_2.sport}"

cours_3 = Course.new(sport: Course::SPORT_TYPES[2], description: 'Prenez des cours de Bodyboard sur Biarritz',  school: school_3, daily_price: rand(100..200).round)
assign_photo_courses(cours_3, ["https://medias.lequipe.fr/img-photo-jpg/amaury-lavernhe-richart/1500000001555919/426:14,1026:614-1200-1200-75/21d4d.jpg"])
puts "Create #{cours_3.sport}"

cours_4 = Course.new(sport: Course::SPORT_TYPES[3], description: 'Prenez des cours de KiteFoil sur Biarritz',  school: school_4, daily_price: rand(100..200).round)
assign_photo_courses(cours_4, ["https://i0.wp.com/kiteparadise.fr/wp-content/uploads/2021/02/foil_houlgate-e1613739197128.jpg?fit=864%2C486&ssl=1"])
puts "Create #{cours_4.sport}"

cours_5 = Course.new(sport: Course::SPORT_TYPES[4], description: 'Prenez des cours de Paddle sur Biarritz',  school: school_5, daily_price: rand(100..200).round)
assign_photo_courses(cours_5, ["https://guidapp.s3.eu-central-1.amazonaws.com/activity_modern/transition3.guidap.co/location-de-paddle-narbonne.JPG"])
puts "Create #{cours_5.sport}"


puts "Finished!"

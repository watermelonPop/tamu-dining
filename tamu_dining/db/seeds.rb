# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

init_users = [
    {first_name:"no", last_name:"credits", uin:"098765432", email:"j@tamu.edu", credits: 0},
    {first_name:"John", last_name:"Doe", uin:"123456789", email:"no-credits@tamu.edu", credits: 50},
    {first_name:"Simone", last_name:"Kang", uin:"232000505", email:"sk21007@tamu.edu", credits: 44},
    {first_name:"Bryan", last_name:"Yan", uin:"123456788", email:"bryanyan@tamu.edu", credits: 50},
    {first_name:"Keegan", last_name:"Reynolds", uin:"123456787", email:"keeg9087@tamu.edu", credits: 50},
    {first_name:"Tyler", last_name:"Fredericksen", uin:"123456786", email:"tfredericks-9792@tamu.edu", credits: 50},
    {first_name:"Kaijie", last_name:"Chen", uin:"123456785", email:"kaijiechen2002@tamu.edu", credits: 50},
    {first_name:"Kelvin", last_name:"Zheng", uin:"123456784", email:"kelvinzheng-21@tamu.edu", credits: 50},
    {first_name:"Nick", last_name:"Ludwig", uin:"123456783", email:"nmludwig21@tamu.edu", credits: 50},
]

init_users.each do |user|
  User.create!(user)
end
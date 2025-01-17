# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Pet.destroy_all
Application.destroy_all

jerry_application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
tony_application = Application.create!(name: "Tony Bologna", street_address: "123 Chicago Ave", city: "Chicago", state: "IL", zip_code: 54321, description: "We love Kangaroos!")
larry_application = Application.create!(name: "Larry Bird", street_address: "456 Boston Road", city: "Boston", state: "MA", zip_code: 67891, description: "Dogs Love Me", status: "Pending")

northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
islandlake = Shelter.create!(foster_program: true, name: "Island Lake Animal Hospital", city: "Denver", rank: 8, street_address: "789 River Road", state: "CO", zip_code: 11556)
banfield = Shelter.create!(foster_program: true, name: "Banfield Animal Hospital", city: "Orlando", rank: 9, street_address:"923 Oscar Meyer Lane", state: "FL", zip_code: 65425)

spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: northshore.id)
frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: islandlake.id)
fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: banfield.id)
pancho = Pet.create!(adoptable: true, age: 5, breed: "Chiuahua", name: "Pancho", shelter_id: northshore.id)

spot_application = PetApplication.create!(application_id: jerry_application.id, pet_id: spot.id, status: jerry_application.status)
fRENCHToasT_application = PetApplication.create!(application_id: jerry_application.id, pet_id: fRENCHToasT.id, status: jerry_application.status)
spot_application1 = PetApplication.create!(application_id: tony_application.id, pet_id: spot.id, status: tony_application.status)
fRENCHToasT_application1 = PetApplication.create!(application_id: tony_application.id, pet_id: fRENCHToasT.id, status: tony_application.status)
frenchie_application = PetApplication.create!(application_id: larry_application.id, pet_id: frenchie.id, status: larry_application.status)

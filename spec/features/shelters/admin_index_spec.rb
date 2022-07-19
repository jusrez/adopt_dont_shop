require 'rails_helper'

RSpec.describe 'Shelter Admin Index' do
  describe 'As a visitor' do
    it 'will show me all the Shelters in the system lised in reverse alphabetical order by name' do
      islandlake = Shelter.create!(foster_program: true, name: "Island Lake Animal Hospital", city: "Denver", rank: 8)
      northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
      banfield = Shelter.create!(foster_program: true, name: "Banfield Animal Hospital", city: "Orlando", rank: 9)

      visit '/admin/shelters'
      
      within '#shelter-0' do
        expect(page).to have_content("North Shore Animal Hospital")
      end
      within '#shelter-1' do
        expect(page).to have_content("Island Lake Animal Hospital")
      end
      within '#shelter-2' do
        expect(page).to have_content("Banfield Animal Hospital")
      end
    end

    it 'will have a section for Shelters with Pending Applications' do
      jerry_application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
      larry_application = Application.create!(name: "Larry Bird", street_address: "456 Boston Road", city: "Boston", state: "MA", zip_code: 67891, description: "Dogs Love Me", status: "Pending")

      northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
      islandlake = Shelter.create!(foster_program: true, name: "Island Lake Animal Hospital", city: "Denver", rank: 8)
      banfield = Shelter.create!(foster_program: true, name: "Banfield Animal Hospital", city: "Orlando", rank: 9)

      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: northshore.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: islandlake.id)
      fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: banfield.id)
      pancho = Pet.create!(adoptable: true, age: 5, breed: "Chiuahua", name: "Pancho", shelter_id: northshore.id)

      spot_application = PetApplication.create!(application_id: jerry_application.id, pet_id: spot.id, status: jerry_application.status)
      frenchie_application = PetApplication.create!(application_id: larry_application.id, pet_id: frenchie.id, status: larry_application.status)

      visit '/admin/shelters'
      expect(page).to have_content("Shelter's with Pending Applications")
    
      within '#pending_shelter-0' do
        expect(page).to have_content("Island Lake Animal Hospital")
      end
    end
  end
end
require 'rails_helper'

RSpec.describe 'the pets index' do
  it 'lists all the pets with their attributes' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it 'only lists adoptable pets' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to_not have_content(pet_3.name)
  end

  it 'displays a link to edit each pet' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_link("Delete #{pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/pets"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)


    visit "/pets"

    fill_in 'Search', with: "Ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end

  it 'has a link to start an application' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
    application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")


    visit "/pets"
    expect(current_path).to eq("/pets")

    click_link("Start an application")
    expect(current_path).to eq("/applications/new")

    fill_in 'Name', with: 'Tony'
    fill_in 'Street address', with: '123 Something Lane'
    fill_in 'City', with: 'Whatever'
    fill_in 'State', with: 'NA'
    fill_in 'Zip code', with: 99999
    fill_in 'Description', with: 'whatever'
    click_on("Submit")

    # expect(current_path).to eq("/applications/(params[:id])")
    expect(page).to have_content('Tony')
  end
end

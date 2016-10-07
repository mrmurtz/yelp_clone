require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up_user1
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      sign_up_user1
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    sign_up_user1
    visit('/')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
  end
end

context 'viewing restaurants' do
  let!(:kfc){Restaurant.create(name:'KFC')}
  scenario 'lets a user view a restaurant' do
   visit '/restaurants'
   click_link 'KFC'
   expect(page).to have_content 'KFC'
   expect(current_path).to eq "/restaurants/#{kfc.id}"
  end

end

context 'editing restaurants' do

  scenario 'let a user edit a restaurant' do
    sign_up_user1
    add_restaurant_kfc
   click_link 'Edit KFC'
   fill_in 'Name', with: 'Kentucky Fried Chicken'
   fill_in 'Description', with: 'Deep fried goodness'
   click_button 'Update Restaurant'
   expect(page).to have_content 'Kentucky Fried Chicken'
   expect(page).to have_content 'Deep fried goodness'
   expect(current_path).to eq '/restaurants'
  end

end

context 'deleting restaurants' do


  scenario 'removes a restaurant when a user clicks a delete link' do
    sign_up_user1
    add_restaurant_kfc
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurant deleted successfully'
  end

end

context 'creating restaurants' do

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do

      sign_up_user1
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
end

end

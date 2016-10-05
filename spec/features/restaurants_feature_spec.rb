require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Add a restaurant')
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end
    scenario 'display restaurants' do
      visit('/restaurants')
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      signup_user
      click_link('Add a restaurant')
      fill_in('Name', with: 'KFC')
      click_button('Create Restaurant')
      expect(page).to have_content('KFC')
      expect(current_path).to eq('/restaurants')
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        signup_user
        click_link('Add a restaurant')
        fill_in('Name', with: 'kf')
        click_button('Create Restaurant')
        expect(page).not_to have_css('h2', text: 'kf')
        expect(page).to have_content('error')
      end
    end

    context 'cannot create duplicate restaurant' do
      scenario 'raises error when user tries to create duplicate' do
        signup_user
        add_kfc_restaurant
        add_kfc_restaurant
        expect(page).to have_content('Name has already been taken Name')
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc) { Restaurant.create(name: 'KFC') }
    scenario 'lets a user view a restaurant' do
      visit('/restaurants')
      click_link('KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness!' }
    scenario 'let a user edit a restaurant' do
      signup_user
      click_link('Edit KFC')
      fill_in('Name', with: 'Kentucky Fried Chicken')
      fill_in('Description', with: 'heart-attack in a bucket')
      click_button('Update Restaurant')
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'heart-attack in a bucket'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness!' }

    scenario 'removes restaurant when user clicks delete link' do
      signup_user
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'adding restaurants when logged in' do
    scenario ' logged out user cannot create restaurant' do
      visit'/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'Log in'
    end
  end



end

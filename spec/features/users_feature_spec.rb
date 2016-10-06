require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it 'can only edit/delete restaurants which theyve created' do
      add_restaurant_kfc
      click_link('Sign out')
      sign_up_user2
      expect(page).not_to have_content('Delete KFC')
    end

    it 'can only leave one review per restaurant' do
      add_restaurant_kfc
      review_kfc
      click_link('Review KFC')
      fill_in('Thoughts', with: 'cant see this')
      select '1', from: 'Rating'
      click_button('Leave Review')
      expect(page).to have_content('You have already reviewed this restaurant')
    end

    it 'can delete own reviews' do
      add_restaurant_kfc
      review_kfc
      delete_kfc
      expect(page).to have_content('Restaurant deleted successfully')
    end

  end

  context "user is not signed in" do
    it "user should not be able to add a restaurant" do
      visit('/')
      click_link('Add a restaurant')
      expect(page).to have_content('Log in')
    end

  end


end

require 'rails_helper'

feature 'reviewing' do

  before { Restaurant.create name: 'KFC' }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario "displays ave rating for kfc of 2" do
    sign_up_user1
    leave_review("Not bad", 1)
    click_link "Sign out"
    sign_up_user2
    leave_review("Good", 5)
    expect(page).to have_content("Average rating: 3")
  end

end

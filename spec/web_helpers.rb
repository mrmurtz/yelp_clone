
def sign_up_user1
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'matt@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up_user2
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'murtz@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def add_restaurant_kfc
  visit('/')
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end

def review_kfc
  click_link('Review KFC')
  fill_in('Thoughts', with: 'shite')
  select '1', from: 'Rating'
  click_button('Leave Review')
end

def delete_kfc
  click_link('Delete KFC')
end

require 'rails_helper'

feature 'reviewing' do
  before {sign_in}
  before {create_restaurant('KFC')}

  scenario 'allows users to leave a review using a form' do
    create_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Tasty!')
  end

  scenario 'a restaurants review is deleted when the restaurant is deleted' do
    create_review
    expect(page).to have_content('Tasty!')
    click_link 'Delete KFC'
    expect(page).not_to have_content('Tasty!')
  end

  scenario 'users can only leave one review per restaurant' do
    create_review
    visit '/restaurants'
    click_link 'Review KFC'
    create_review
    expect(page).to have_content('You have already reviewed this restaurant')
  end

  scenario 'users can delete only their own reviews' do
    create_review
    expect(current_path).to eq '/restaurants'
    click_link 'Sign out'
    new_user
    click_link 'Delete KFC Review'
    expect(page).to have_content('You can only delete your own reviews')
  end

  scenario 'a review displays an endorsement associated with it', js: true do
    create_review
    visit '/restaurants'
    click_link 'Like'
    expect(page).to have_content('1 Like')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '2')
    click_link 'Sign out'
    new_user
    leave_review('Great', '4')
    expect(page).to have_content('Average rating: ★★★☆☆')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  def create_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Tasty!"
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  def sign_in
    user = create(:user)
    login_as(user, :scope => :user)
  end

  def create_restaurant(name)
    visit('/restaurants')
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end

  def new_user
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: "test2@test.com"
    fill_in 'user_password', with: "testtest"
    fill_in 'user_password_confirmation', with: "testtest"
    click_button 'Sign up'
  end
end

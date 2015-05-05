require 'rails_helper'

feature 'reviewing' do
  before {sign_in}
  before {create_restaurant('KFC')}
  before {create_review}

  scenario 'allows users to leave a review using a form' do
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Tasty!')
  end

  scenario 'a restaurants review is deleted when the restaurant is deleted' do
    expect(page).to have_content('Tasty!')
    click_link 'Delete KFC'
    expect(page).not_to have_content('Tasty!')
  end

  scenario 'users can only leave one review per restaurant' do
    expect(current_path).to eq '/restaurants'
    click_link 'Review KFC'
    create_review
    expect(page).to have_content('You have already reviewed this restaurant')
  end

  def create_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Tasty!"
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  def sign_in
    user = create(:user, id: 1)
    login_as(user, :scope => :user)
  end

  def create_restaurant(name)
    visit('/restaurants')
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end
end

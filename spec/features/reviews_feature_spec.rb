require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

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

  def create_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Tasty!"
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end
end

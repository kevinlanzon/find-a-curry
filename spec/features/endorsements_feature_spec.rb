require 'rails_helper'

feature 'endorsing reviews' do

  before do
    user = create(:user)
    login_as(user, :scope => :user)
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'Nice')
  end

  scenario 'a review display an endorsement associated with it', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
    save_and_open_page
  end
end

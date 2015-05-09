require 'rails_helper'

feature 'endorsing reviews' do

  before do
    user = create(:user)
    login_as(user, :scope => :user)
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'Nice')
  end

  scenario 'a review has a link to endorse a review', js: true do
    visit '/restaurants'
    save_and_open_page
    expect(page).to have_link('Endorse')
  end

  scenario 'a review display an endorsement associated with it', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'a review displays multiple endorsements associated with it', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    click_link 'Endorse'
    expect(page).to have_content('2 endorsements')
  end
end

require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
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
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_in
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      sign_in
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'let a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before {sign_in}
    before {create_restaurant('KFC')}

    scenario 'let a user edit a restaurant' do
      visit '/'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end


    scenario 'users can only edit restaurants which they have created' do
      visit('/')
      click_link 'Sign out'
      new_user
      click_link 'Edit KFC'
      expect(page).to have_content 'Only the creator of the restaurant can edit it'
    end
  end

  context 'deleting restaurants' do
    before {sign_in}
    before {create_restaurant('KFC')}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'users can only delete restaurants which they have created' do
      visit('/')
      click_link 'Sign out'
      new_user
      click_link 'Delete KFC'
      expect(page).to have_content 'Only the creator of the restaurant can delete it'
    end
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

  def new_user
    visit '/restaurants'
    click_link 'Sign up'
    fill_in 'Email', with: "test2@test.com"
    fill_in 'Password', with: "testtest"
    fill_in 'Password confirmation', with: "testtest"
    click_button 'Sign up'
  end
end

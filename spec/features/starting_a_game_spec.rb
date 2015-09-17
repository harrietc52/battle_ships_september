require 'spec_helper'

feature 'Starting a new game' do

  scenario 'Asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Recieves name' do
  	visit '/'
    click_link 'New Game'
  	fill_in('name', :with => 'Harry')
  	click_button 'Submit'
  	expect(page).to have_content "Hello Harry!"
  end

  scenario 'Does not receive name' do
    visit '/'
    click_link 'New Game'
    fill_in 'name', with: ''
    click_button 'Submit'
    expect(page).to have_content 'Please enter your name'
  end

  scenario 'Goes to ship placement when start button is pressed' do
    visit '/name'
    fill_in('name', :with => 'Harry')
  	click_button 'Submit'
    click_button 'Start'
    expect(page).to have_content 'Choose type of ship:'
  end

  scenario 'Ship placement page remembers player\'s name' do
    visit '/name'
    fill_in('name', :with => 'Harry')
  	click_button 'Submit'
    click_button 'Start'
    expect(page).to have_content 'Place your ships, Harry.'
  end

end

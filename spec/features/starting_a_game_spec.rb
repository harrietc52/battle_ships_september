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
  	expect(page).to have_content "Harry's Game!"
  end

  scenario 'Does not receive name' do
    visit '/'
    click_link 'New Game'
    fill_in 'name', with: ''
    click_button 'Submit'
    expect(page).to have_content 'Please enter your name'
  end

  scenario 'Shows board' do
    visit '/board_example'
    expect(page).to have_content 'Place holder: board'
  end

end

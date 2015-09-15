require 'spec_helper'

feature 'Starting a new game' do

  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'A board is rendered in the browser when a name is entered' do
  	visit '/'
  	click_link 'New Game'
  	fill_in('name', :with => 'Harry')
  	click_button 'Submit'
  	expect(page).to have_content 'Im a board'
  end

end

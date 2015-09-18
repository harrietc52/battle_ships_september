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

  scenario 'Remove ship type from drop down when placed' do
    visit '/name'
    fill_in('name', :with => 'Harry')
    click_button 'Submit'
    click_button 'Start'
    fill_in('position', :with => 'A1')
    click_button 'Submit'
    expect(page).to have_no_content 'Aircraft Carrier (5)'
  end

  scenario 'Placing all ships to show up on the baord' do
    visit '/ship_placement'
    fill_in('position', :with => 'B1')
    click_button 'Submit'
    fill_in('position', :with => 'C1')
    click_button 'Submit'
    fill_in('position', :with => 'D1')
    click_button 'Submit'
    fill_in('position', :with => 'E1')
    click_button 'Submit'
    fill_in('position', :with => 'F1')
    click_button 'Submit'
    expect(page).to have_css("div[style='background-color:#009933; height:40px; width:40px; display:inline-block; border: 1px solid white']", count: 22) #need to sort out previous test ship still appearing in test
    expect(page).to have_css("div[style='background-color:#0000FF; height:40px; width:40px; display:inline-block; border: 1px solid white']", count: 78)
  end

  scenario 'Pressing start game button takes us to new page' do
    visit '/ship_placement'
    click_button 'Start game'
    expect(page).to have_css("div[style='background-color:#0000FF; height:40px; width:40px; display:inline-block; border: 1px solid white']", count: 200)
  end

  # scenario 'Goes to game page when all ships have been placed' do
  #   visit '/ship_placement'
  # end

end

require 'rails_helper'

RSpec.feature 'home index ', type: :feature do
  before(:each) do
    visit root_path
  end

  scenario 'should have a heading with text' do
    expect(page).to have_css('h1', text: 'Budgeti')
  end

  scenario 'should have a link to the login page' do
    expect(page).to have_link('LOG IN', href: new_user_session_path)
  end

  scenario 'should have a link to the sign up page' do
    expect(page).to have_link('SIGN UP', href: new_user_registration_path)
  end
end

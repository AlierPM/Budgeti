require 'rails_helper'

RSpec.feature 'Payments index', type: :feature do
  let!(:user) { create(:user, :confirmed) }
  let!(:category) { create(:category, user:) }
  let!(:payment) { create(:payment, category:, author: user) }

  before do
    sign_in user
    visit category_payment_path(category, payment)
  end

  scenario 'displays payment details' do
    expect(page).to have_content(payment.amount)
    expect(page).to have_content(payment.category.name)
  end

  scenario 'display Payment amount' do
    expect(page).to have_content('350')
  end

  scenario 'display Payment category' do
    expect(page).to have_content('Laptop PC')
  end
end

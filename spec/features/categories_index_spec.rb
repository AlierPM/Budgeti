require 'rails_helper'

RSpec.feature 'Categories index', type: :feature do
  let!(:user) { create(:user, :confirmed) }
  let!(:category) { create(:category, user:) }

  before do
    sign_in user
    visit categories_path
  end

  scenario 'displays category names' do
    expect(page).to have_content(category.name)
  end

  context 'when displaying category details' do
    let!(:payment) { create(:payment, category:, author: user) }

    scenario 'displays category images, total amount, and monthly budget' do
      expect(page).to have_css("img[src*='laptop_image.png']")
    end

    scenario 'navigates to transaction page when category is clicked' do
      click_on category.name
      expect(page).to have_current_path(category_payments_path(category))
    end
  end
end

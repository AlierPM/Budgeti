require 'rails_helper'

RSpec.describe '/payments', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user, email: 'new@example.com', name: 'Example Name', password: 'password123') }

  before(:each) do
    user.confirm # Confirm the user's email
    login_as(user, scope: :user)

    @file = Tempfile.new(['laptop_image', '.jpeg'])
    @icon = fixture_file_upload(@file.path, 'image/jpeg')

    @category = Category.create!(name: 'laptop', user:, icon: @icon)
  end

  after(:each) do
    user.payments.destroy_all
    user.categories.destroy_all
    user.destroy if user.persisted?
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Payment.create!(name: 'test', amount: 12, author: user, category: @category)
      get category_payments_url(@category)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_payment_path(@category)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Payment' do
        expect do
          post category_payments_path(@category), params: { payment: { name: 'test', amount: 12 } }
        end.to change(Payment, :count).by(1)
      end

      it 'redirects to the payments page' do
        post category_payments_path(@category), params: { payment: { name: 'test', amount: 12 } }
        expect(response).to redirect_to(category_payments_url(@category))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Payment' do
        expect do
          post category_payments_path(@category), params: { payment: { name: 'test' } }
        end.to change(Payment, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post category_payments_path(@category), params: { payment: { name: 'test' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Sessions" do
  include Devise::Test::ControllerHelpers

  # it "signs user in and out" do
  #   user = User.create!(email: "user@example.org", password: "very-secret", password_confirmation: "very-secret", role: "admin", first_name: "admin", last_name: "Do")
  #   user.valid?
    
  #   sign_in user
  #   get :new    
  #   sign_out user
  #   get root_path
  #   expect(controller.current_user).to be_nil
  # end

end

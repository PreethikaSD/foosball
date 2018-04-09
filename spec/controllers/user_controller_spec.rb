require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	include Devise::Test::ControllerHelpers

  let(:user_params) { { first_name: "John", last_name: "Ak", role: "admin", email: "john@example.com", password: "johnfoosball" } }
  let(:user) { User.create(user_params) }
  login_user
  before(:all) do
    user = build(:user)
  end


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    it "returns http success" do
    	get :show, params: { id: user.id }
    	expect(response.status).to eq(200)
    end

    it "has the correct assignment" do
    	get :show, params: { id: user.id }
      	expect(assigns(:user)).not_to be_nil
      	expect(assigns(:user)).to eq user
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "POST #create" do
  	it "creates a record" do
  		expect(user).to be_valid
  	end

  	it "has a unique username" do
    	user2 = build(:user, email: "bob@gmail.com")
    	expect(user2).to be_valid
	end

    it "has a invalid email" do
    	user2 = build(:user, email: "bob")
    	expect(user2).to_not be_valid
  	end

  	it "user can be created by only admin role" do
  		current_user = sign_in user
  		user3 = create(:user, email: "bob23@gmail.com", role: "user")
  		expect(user3).to be_valid
  	end

  	it "users with non-admin role cannot create user" do
  		user2 = build(:user, role: "non-admin")
  		current_user = sign_in user2
  		expect(user2).to_not be_valid
  	end
  end

	describe "PUT update/:id" do
	  let(:attr) do 
	    { :first_name => 'Prem', :role => 'new role' }
	  end

	  before(:each) do
	    put :update, params: {:id => user.id, :user => attr}
	    user.reload
	  end

	  it "should redirect to user show page" do
	  	response.should redirect_to(user) 
	  end
	  	
	  it "verify if record is updated" do
	  	user.first_name.should eql attr[:first_name] 
	  end

	  it "verify if record is updated" do
	  	user.role.should eql attr[:role] 
	  end
	end
end




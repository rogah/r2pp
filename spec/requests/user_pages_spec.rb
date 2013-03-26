require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', text: 'Signup') }
  	it { should have_selector('title', text: full_title('Signup')) }
  end

  describe "profile page" do

  	let(:user) { FactoryGirl.create(:user) }
  	
    before { visit user_path(user) }

  	it { should have_selector('h1', text: user.name) }
  	it { should have_selector('title', text: full_title(user.name)) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:user_attr) { FactoryGirl.attributes_for(:user) }
    
    let(:submit) { "Signup" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do

      before do
        fill_in "Name",         with: user_attr[:name]
        fill_in "Email",        with: user_attr[:email]
        fill_in "Password",     with: user_attr[:password]
        fill_in "Confirmation", with: user_attr[:password_confirmation]
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do

        before { click_button submit }

        let(:user) { User.find_by_email(user_attr[:email]) }

        it { should have_selector('title', text: full_title(user.name)) }
      end
    end
  end
end
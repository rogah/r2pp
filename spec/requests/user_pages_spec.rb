require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "Signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', text: 'Users#signup') }
  	it { should have_selector('title', text: full_title('Signup')) }
  end
end

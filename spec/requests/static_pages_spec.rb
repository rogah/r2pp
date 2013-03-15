require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
  	before { visit home_path }

    it { should have_selector('h1', text: 'StaticPages#home') }
    it { should have_selector('title', text: full_title('Home')) }
  end

  describe "About page" do
  	before { visit about_path }

    it { should have_selector('h1', text: 'StaticPages#about') }
    it { should have_selector('title', text: full_title('About')) }
  end
end

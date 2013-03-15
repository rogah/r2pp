require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
  	before { visit '/static_pages/home' }

    it { should have_selector('h1', text: 'StaticPages#home') }
    it { should have_selector('title', text: full_title('Home')) }
  end

  describe "About page" do
  	before { visit '/static_pages/about' }

    it { should have_selector('h1', text: 'StaticPages#about') }
    it { should have_selector('title', text: full_title('About')) }
  end
end

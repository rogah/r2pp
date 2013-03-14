require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
  	
    it "should have the h1 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'StaticPages#home')
    end

    it "should have the title 'Home'" do
    	visit '/static_pages/home'
    	page.should have_selector('title', :text => 'R2 Production Planning - Home')
    end
  end

  describe "About page" do
  	
    it "should have the h1 'About'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'StaticPages#about')
    end

    it "should have the title 'About'" do
    	visit '/static_pages/about'
    	page.should have_selector('title', :text => 'R2 Production Planning - About')
    end
  end
end

require 'spec_helper'

describe "StaticPages" do
  subject { page }

	it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
  end

  describe "Home" do
  	before { visit root_path }
  	it { should have_selector('title', text: full_title('')) }
  	it { should have_selector('h1', text: 'Home') }
  end

  describe "Help" do
  	before { visit help_path }
  	it { should have_selector('title', text: full_title('Help')) }
  	it { should have_selector('h1', text: 'Help') }
  end

  describe "About" do
  	before { visit about_path }
  	it { should have_selector('title', text: full_title('About')) }
  	it { should have_selector('h1', text: 'About') }
  end

  describe "Contact" do
  	before { visit contact_path }
  	it { should have_selector('title', text: full_title('Contact')) }
  	it { should have_selector('h1', text: 'Contact') }
  end
end

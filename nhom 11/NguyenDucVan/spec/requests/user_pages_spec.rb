require 'spec_helper'

describe "User pages" do

  subject { page }

	describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 5.times { FactoryGirl.create(:user) } }
    after(:all)  { User.delete_all }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
	end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

		it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "van"
        fill_in "Email",        with: "van@mail.com"
        fill_in "Password",     with: "123123"
        fill_in "Confirmation", with: "123123"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
      	before { click_button submit }
        let(:user) { User.find_by_email('van@mail.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      	it { should have_link('Sign out') }
      end
    end
  end
end

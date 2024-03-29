require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_title('Sign in') }

    describe "with invalid login information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_error_message }
      end
    end

    describe "with valid login information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(full_title(user.name)) }
      it { should have_link('Users'), href: users_path }
      it { should have_link('Profile'), href: user_path(user) }
      it { should have_link('Settings'), href: edit_user_path(user) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in') }

      describe "followed by sign out" do
        before { click_link "Sign out" }

        it { should have_link("Sign in") }
        it { should_not have_link('Users') }
        it { should_not have_link('Profile') }
        it { should_not have_link('Settings') }
        it { should_not have_link('Sign out') }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed in user" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in users controller" do
        before { visit edit_user_path(user) }
        it { should have_title('Sign in') }

        describe "visit the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end

        describe "when atempt to visit protected page" do
          before do
            sign_in(user)
          end

          describe "after signing in" do
            it "should render the desired protected page" do
              page.should have_selector('title', text: 'Edit user')
            end
          end
        end

        describe "summiting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title('Edit user') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end

    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        delete user_path(admin)
      end

      it { should_not have_success_message() }
    end
  end
end

require "spec_helper"

describe "User pages" do

  subject { page }

  describe "signed in user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "go to sign up page" do
      before { visit signup_path }
      it { should have_title(full_title('')) }
    end

    describe "post to User#create" do
      before { post users_path }
      it { should have_title(full_title('')) }
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector("h1",    text: "Sign up") }
    it { should have_title(full_title("Sign up")) }

    let(:submit) { "Create my account" }

    describe "with invalid form" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submit" do
        before { click_button submit }

        it { should have_title(full_title("Sign up")) }
        it { should have_content("error") }
      end
    end

    user_email = "example@someweb.com"

    describe "with valid form" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: user_email
        fill_in "Password", with: "s3cr3t"
        fill_in "Confirmation", with: "s3cr3t"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by 1
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email(user_email) }

        it { should have_title(full_title(user.name)) }
        it { should have_selector("div.alert.alert-success", text: "Welcome") }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "First post") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Hello, world") }

    before do
      visit user_path(user)
    end

    it { should have_selector("h1", text: user.name) }
    it { should have_title(user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

    describe "follow/unfollow button" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end

    describe "stats" do
      it { should have_link("#{user.followed_users.count} following", href: following_user_path(user)) }
      it { should have_link("#{user.followers.count} followers", href: followers_user_path(user)) }
    end
  end

  describe "edit page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector("h1", text: "Update your profile") }
      it { should have_title(full_title("Edit user")) }
      it { should have_link("change", href: "http://gravatar.com/emails") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content("error") }
    end

    describe "with valid information" do
      let(:new_name) { "New name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_success_message "Profile updated" }
      it { should have_link("Sign out", href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }

    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_selector('h1', text: 'All users') }

    describe "pagination" do
      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('Delete') }

      describe "as admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('Delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "following/followers page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      user.follow!(other_user)
    end

    describe "followed users" do
      before { visit following_user_path(user) }

      it { should have_title('Following') }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before { visit followers_user_path(other_user) }

      it { should have_title('Followers') }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end

end
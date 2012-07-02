require 'spec_helper'

describe User do
  before do
  	@user = User.new(name: "van", email: "van@mail.com", password: "123456", password_confirmation: "123456")
  end

  subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:admin) }
	it { should respond_to(:authenticate) }

	it { should be_valid }
	it { should_not be_admin }

	describe "with admin attribute set to 'true'" do
		before { @user.toggle!(:admin) }

		it { should be_admin }
	end

	describe "validate name" do
		describe "name should not blank" do
			before { @user.name = '' }
			it { should_not be_valid }
		end

		describe "name should not longer than 50 characters" do
			before { @user.name = 'a'*51 }
			it { should_not be_valid }
		end
	end

	describe "validate email" do
		describe "should not blank" do
			before { @user.email = '' }
			it { should_not be_valid }
		end

		describe "when email format is invalid" do
	    it "should be invalid" do
	      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
	      addresses.each do |invalid_address|
	        @user.email = invalid_address
	        @user.should_not be_valid
	      end
	    end
	  end

	  describe "when email format is valid" do
	    it "should be valid" do
	      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	      addresses.each do |valid_address|
	      	@user.email = valid_address
        	@user.should be_valid
      	end
   	 	end
  	end

		describe "should be unique" do
			before do
				user_dup = @user.dup
				user_dup.email = @user.email.upcase
				user_dup.save
			end
			it { should_not be_valid }
		end
	end

	describe "validate password" do
		describe "should not blank" do
			before { @user.password = @user.password_confirmation = ' ' }
			it { should_not be_valid }
		end

		describe "not same with password_confirmation" do
			before { @user.password = 'invalid' }
			it { should_not be_valid }
		end

		describe "when password confirmation is nil" do
    	before { @user.password_confirmation = nil }
    	it { should_not be_valid }
  	end
	end

	describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by_email(@user.email) }

  	describe "with valid password" do
    	it { should == found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
    	let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    	it { should_not == user_for_invalid_password }
   		specify { user_for_invalid_password.should be_false }
  	end
	end

	describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end

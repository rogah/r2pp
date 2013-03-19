# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  active          :boolean          default(FALSE)
#  last_sign_in    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted_at      :datetime
#

require 'spec_helper'

describe User do

	before { 
		@user = User.new(
			name: 'Foobar', 
			email: 'foo@bar.com', 
			password: "foobar", 
			password_confirmation: "foobar") 
	}

	subject { @user }	

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
  	it { should respond_to(:password_confirmation) }
  	it { should respond_to(:authenticate) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = '' }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = 'a' * 51 }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = '' }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			
			emails = %w[user@foo,com 
						user_at_foo.org 
						example.user@foo. 
						foo@bar_baz.com 
						foo@bar+baz.com]
            
            emails.each { |invalid_email|
            	@user.email = invalid_email
            	@user.should_not be_valid
            }
		end
	end

	describe "when email is valid" do
		it "should be valid" do
			
			emails = %w[foo@bar.com 
						foo.bar@bar.com 
						foo+bar@bar.com 
						foo-bar@bar.com 
                		foo_bar@bar.com 
                		foo@3bar.com 
                		foo3@bar.com 
                		foo.bar@bar.com.br 
                		foo@bar.jp 
                		FOO_BAR@FOO.BAR.COM]
            
            emails.each { |valid_email|
            	@user.email = valid_email
            	@user.should be_valid
            }
		end
	end

	describe "when email is already taken" do
		before {
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save 
		}

		it { should_not be_valid }
	end

	describe "email address with mixed case" do
		let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

		it "should be saved as all lower-case" do
			@user.email = mixed_case_email
			@user.save
			@user.reload.email.should == mixed_case_email.downcase
		end
	end

	describe "when password is not pressent" do
		before { @user.password = @user.password_confirmation = '' }
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = 'a' * 5 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }

		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate('invalid') }

			it { should_not == user_for_invalid_password }
	    	specify { user_for_invalid_password.should be_false }
	  	end
	end
end
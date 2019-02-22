require 'rails_helper'

RSpec.describe User, type: :model do


	context 'validation tests' do
		before :each do 
	      User.delete_all
	      ActiveRecord::Base.connection.reset_pk_sequence!(:users) 
	      User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password_digest: "123").save
	    end


	    it 'should create a user with valid data - happy path' do
			user = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password_digest: "123").save
      		expect(user).to eq(true)	    
      	end


	    it 'should have a first_name - unhappy path' do
			user = User.new(last_name: "last", email: "name@mail.com", password_digest: "123").save
      		expect(user).to eq(false)		    
      	end


	    it 'should have a last_name - unhappy path' do
			user = User.new(first_name: "first", email: "name@mail.com", password_digest: "123").save
      		expect(user).to eq(false)		    
      	end


	    it 'should have an email - unhappy path' do
			user = User.new(first_name: "first", last_name: "last", password_digest: "123").save
      		expect(user).to eq(false)		    
      	end


	    it 'should have a password - unhappy path' do
			user = User.new(first_name: "first", last_name: "last", email: "name@mail.com").save
      		expect(user).to eq(false)		    
      	end
  
      	it 'should have a unique email - unhappy path' do
			user = User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password_digest: "123").save
      		expect(user).to eq(false)		    
      	end

      	it 'should have a default role = customer - happy path' do
			user = User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password_digest: "123")
      		expect(user.role).to eq('customer')		    
      	end

      	it 'should have a default role = customer - unhappy path' do
			user = User.create(first_name: "first", last_name: "last", email: "duplicate@mail.com", password_digest: "123", role: "admin")
      		expect(user).not_to be_valid	    
      	end

      	it 'should have a valid email format - unhappy path' do
			user = User.create(first_name: "first", last_name: "last", email: "email", password_digest: "123")
      		expect(user).not_to be_valid    
      	end
	end

	context 'associations test' do
		
		it 'success: has many votes' do
	        expect(User.reflect_on_association(:votes).macro).to eq(:has_many)
	    end

	    it 'success: has many recipes' do
	        expect(User.reflect_on_association(:recipes).macro).to eq(:has_many)
	    end

	end


	context 'test search custom model method' do
		it 'gives the result of the search - happy path' do
			user_1 = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password_digest: "123").save
	        user_2 = User.new(first_name: "second", last_name: "last", email: "name1@mail.com", password_digest: "123").save
	        users = User.all
	        user = User.search("last")
	        expect(user.length).to eq(users.length)
		end

		it 'gives an error the result of the search - unhappy path' do
			user_1 = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password_digest: "123").save
	        user_2 = User.new(first_name: "second", last_name: "last", email: "name1@mail.com", password_digest: "123").save
	        users = User.all
	        expect{ User.search }.to raise_error(ArgumentError)
		end
	end


end

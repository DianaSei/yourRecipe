require 'rails_helper'

describe "GET '/' - homepage title", type: :feature do
  it "welcomes the users with the name of the app 'YourRecipe'" do
    visit '/'
    expect(page.title).to have_content("YourRecipe")
    puts 'the homepage title is YourRecipe!'
  end
end

describe "dispalays form to sign in when clicking a button", type: :feature do
  it "dispalays a form" do
    visit '/'
    click_button('Login')
    expect(page.should have_content('Login'))
  end
end



require 'spec_helper'

feature "User invites friend" do
  scenario "User successfully invites friend and invitation is accepted", { js: true, vcr: true } do
    alice = Fabricate(:user)
    sign_in(alice)

    visit new_invitation_path
    fill_in "Friend's Name", with: "John Doe"
    fill_in "Friend's Email Address", with: "john@example.com"
    fill_in "Message", with: "Please join!"
    click_button "Send Invitation"
    sign_out

    open_email "john@example.com"
    current_email.click_link "Accept this invitation"

    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"
    click_button "Pay with Card"

    fill_in "Card number:", with: "4242424242424242"
    fill_in "Expires:", with: "07/2015"
    fill_in "Name on card:", with: "Raluca Komartin"
    fill_in "Card code", with: "123"
    click_button "Pay $9.99"

    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "password"
    click_button "Sign in"

    expect(page).to have_content "John Doe"

    clear_email
  end
end
shared_examples "requires sign in" do
	it "redirects to the sign in page" do
		session[:user_id] = nil
		action
		expect(response).to redirect_to sign_in_path
	end
end

shared_examples "requires admin" do
  it "redirects the regular user to the home path" do
    set_current_user
    action
    expect(response).to redirect_to home_path
  end
end
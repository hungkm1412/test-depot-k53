def full_title(page_title)
		base_title = "My practise app"
		if page_title.empty?
			full_title = base_title
		else
			full_title = "#{base_title} | #{page_title}"
		end
	end

def sign_in(user)
	visit signin_path
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
	# Sign in when not using Capybara as well
	cookies[:remember_token] = user.remember_token
end

module PageHelper
  RSpec::Matchers.define :have_error_message do |message|
    match do |page|
      page.should have_selector('div.alert.alert-error', text: message)
    end
  end

  RSpec::Matchers.define :have_error_title do |title|
    match do |page|
      page.should have_selector('title',text: title)
    end
  end

  RSpec::Matchers.define :have_error_heading do |heading|
    match do |page|
      page.should have_selector('h1',text: heading)
    end
  end
end

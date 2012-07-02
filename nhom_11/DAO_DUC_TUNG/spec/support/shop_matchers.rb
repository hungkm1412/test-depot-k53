
module Shop
  module Matchers

    RSpec::Matchers.define :have_error_message do |message|
      match do |page|
        page.should have_selector('div.alert.alert-error', text: message)
      end
    end

    RSpec::Matchers.define :have_success_message do |message|
      match do |page|
        page.should have_selector('div.alert.alert-success', test: message)
      end
    end

    RSpec::Matchers.define :have_title do |title|
      match do |page|
        page.should have_selector('title', text: title)
      end
    end

    RSpec::Matchers.define :allow_mass_assignment_of do |attr|
      match do |model|
        model.respond_to?(attr) and model.class.accessible_attributes.include?(attr)
      end
    end

  end
end

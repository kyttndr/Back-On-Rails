When(/^I go to the homepage$/) do
  visit root_path
end

Then /^I should (not )?see an element "([^"]*)"$/ do |negate, selector|
  expectation = negate ? :should_not : :should
  page.send(expectation, have_css(selector))
end

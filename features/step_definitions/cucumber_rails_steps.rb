When(/^I go to the homepage$/) do
  visit root_path
end

Then (/^I should (not )?see the navbar "([^"]*)"$/) do |negate, selector|
  expectation = negate ? :should_not : :should
  page.send(expectation, have_css(selector))
end

Then (/^I should (not )?see the search bar "([^"]*)"$/) do |negate, selector|
  expectation = negate ? :should_not : :should
  page.send(expectation, have_css(selector))
end

Then (/^I should see the information "([^"]*)" in the search bar$/) do |infomation|
  expect(page).to have_field("search_item", placeholder: infomation)
end

Then (/^I should (not )?see the tag option for search bar "([^"]*)"$/) do |negate, selector|
  expectation = negate ? :should_not : :should
  page.send(expectation, have_css(selector))
end

Then (/^I should search for "([^"]*)"$/) do |item|
  within("#item-lookup-form") do
    fill_in 'search_item', with: item
  end
  click_button 'search'
end

Then (/^I should be redirected to the search result page$/) do
  expect(page.current_path).to eq search_items_path
end

Then (/^I should see the information of "([^"]*)"$/) do |information|
  expect(page).to have_content(information)
end

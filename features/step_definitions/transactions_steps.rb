Given (/^I am logged in$/) do
    @user = FactoryBot.build(:user)
    @user.save

    visit login_path
    fill_in("session[email]", :with => @user.email)
    fill_in("session[password]", :with => @user.password)
    click_button("Log in")
end

When (/^I go to the pending transactions page$/) do
  visit pending_transactions_path
end

Then (/^I should (not )?see the calendar "([^"]*)"$/) do |negate, selector|
  expectation = negate ? :should_not : :should
  page.send(expectation, have_css(selector))
end

Then (/^I should see the text "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end



#Given (/^There is an item$/) do
    #@item = FactoryBot.build(:item)
    #flag = @item.save
    #puts "\n\n\n issaved: #{flag} \n\n\n"
#end

#When (/^I go to the new transaction page$/) do
#    puts "\n\n\n\n\n FLAG: #{@item.id}\n\n\n\n\n"
#    visit new_transaction_path(item_id: @item.id)
#end

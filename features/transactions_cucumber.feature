Feature: Transactions Cucumber
I want our users to be able the experience the transactions pages
and its functionality to the fullest

Scenario: User sees the calendar in the pending transactions page
Given I am logged in
When I go to the pending transactions page
Then I should see the navbar ".navbar"
And I should see the calendar ".simple-calendar"
And I should see the text "PENDING TRANSACTIONS"


#Scenario: User creates a borrow request
#Given I am logged in
#And There is an item
#When I go to the new transaction page

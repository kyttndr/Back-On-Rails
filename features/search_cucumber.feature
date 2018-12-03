Feature: Search Cucumber
I want our users to be able to use the search function

Scenario: User searches for some items
When I go to the homepage
Then I should see the search bar "#search_item"
Then I should search for "boots"
Then I should be redirected to the search result page
Then I should see the information of "No items found."

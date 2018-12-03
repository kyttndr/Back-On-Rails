Feature: Index Cucumber
I want our users to be clear what we do when they visit our site
So that they have a better experience

Scenario: User sees the index page
When I go to the homepage
Then I should see the navbar ".index_navbar"
Then I should see the search bar "#search_item"
Then I should see the information "Need to borrow something? Your neighbours might have it! Search for item here. " in the search bar
Then I should see the tag option for search bar "#tag_id"

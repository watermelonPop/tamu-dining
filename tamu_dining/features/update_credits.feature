Feature: update credits

  As a outside application interfacing with tamu_dining,
  So that I can update user credits,
  I want to be able to increase or decrease user credits using api calls.


Background: users in database

  Given the following users exist:
  | first_name   | last_name | uin       | email               | credits |
  | Al           | Gorithm   | 879861986 | al_gorithm@tamu.edu | 48      |
  | Shrimpfried  | Rice      | 973415535 | shrimprice@tamu.edu | 32      |
  | Lemon        | Jello     | 463525785 | lemonj@tamu.edu     | 2       |

Scenario: Adding credits to user
  Given that I'm editing uin "973415535"
  And I "increase" credits by 10
  Then I should have 42 credits

Scenario: Removing credits from user
  Given that I'm editing uin "973415535"
  And I "decrease" credits by 10
  Then I should have 22 credits

Scenario: Removing more credits than available from user
  Given that I'm editing uin "463525785"
  And I "decrease" credits by 10
  Then I should get a "error" message
  And I should have 2 credits
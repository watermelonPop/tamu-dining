Feature: update credits

  As a outside application interfacing with tamu_dining,
  So that I can update user credits,
  I want to be able to increase or decrease user credits using api calls.


Background: users in database

  Given the following users exist:
  | first_name   | last_name | uin       | email               | credits |
  | Al           | Gorithm   | 879861986 | al_gorithm@tamu.edu | 48      |
  | Shrimpfried  | Rice      | 973415535 | shrimprice@tamu.edu | 32      |
  | Lemon        | Jello     | 463525785 | lemonj@tamu.edu     | 4       |

Scenario: Adding credits to user
  Given that I "increase" user "973415535" credits by 10
  Then I should see 'status' 'success'
  And I should see the 'credits' '42'

Scenario: Removing credits from user
  Given that I "decrease" user "973415535" credits by 10
  Then I should see 'status' 'success'
  And I should see the 'credits' '22'

Scenario: Removing more credits than available from user
  Given that I "decrease" user "463525785" credits by 10
  Then I should see 'status' 'error'
  And I should see the 'credits' '4'

Scenario: Adding negative credits from user
  Given that I "increase" user "973415535" credits by 10
  Then I should see 'status' 'error'
  And I should see the 'credits' '32'

Scenario: Removing negative credits from user
  Given that I "decrease" user "973415535" credits by 10
  Then I should see 'status' 'error'
  And I should see the 'credits' '32'
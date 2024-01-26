Feature: api fetch

  As a software developer,
  So that I can create a meal plan app,
  I want to be able to grab user information through an api call.


Background: users in database

  Given the following users exist:
  | first_name   | last_name | uin       | email               | credits |
  | Al           | Gorithm   | 879861986 | al_gorithm@tamu.edu | 48      |
  | Shrimpfried  | Rice      | 973415535 | shrimprice@tamu.edu | 32      |
  | Lemon        | Jello     | 463525785 | lemonj@tamu.edu     | 0       |
  | Renee        | Rapp      | 361543783 | rr@tamu.edu         | 24      |
  | Shakira      | Shakira   | 643971828 | shakira@tamu.edu    | 44      |

Scenario: Fetch all users
    When I go to the users path
    Then I should see a user called Al Gorithm
    And I should see a user called Shrimpfried Rice
    And I should see a user called Lemon Jello
    And I should see a user called Renee Rapp
    And I should see a user called Shakira Shakira

Scenario: Fetch one user
    When I go to the user page for uin 361543783
    Then I should see a user called Renee Rapp
    And I should see the email rr@tamu.edu
    And I should see 48 credits

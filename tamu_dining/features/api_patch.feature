Feature: api patch

  As a software developer,
  So that I can create a meal plan app,
  I want to be able to update user meal credits through an api call.


Background: users in database

  Given the following users exist:
  | first_name   | last_name | uin       | email               | credits |
  | Al           | Gorithm   | 879861986 | al_gorithm@tamu.edu | 48      |
  | Shrimpfried  | Rice      | 973415535 | shrimprice@tamu.edu | 32      |
  | Lemon        | Jello     | 463525785 | lemonj@tamu.edu     | 0       |
  | Renee        | Rapp      | 361543783 | rr@tamu.edu         | 24      |
  | Shakira      | Shakira   | 643971828 | shakira@tamu.edu    | 44      |

Scenario: Add 15 credits to Lemon's account
    When I go to patch user with uin '463525785' to add 15 credits
    Then I should see 'Credits updated successfully'
    And user with uin '463525785' should have 15 credits
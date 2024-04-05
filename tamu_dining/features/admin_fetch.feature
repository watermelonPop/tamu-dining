Feature: admin fetch

  As a software developer,
  So that I can create a meal plan app,
  I want to be able to grab admin information through an api call.


Background: admins in database

  Given the following admins exist:
  | first_name   | last_name | email               |
  | Al           | Gorithm   | al_gorithm@tamu.edu |
  | Shrimpfried  | Rice      | shrimprice@tamu.edu |
  | Lemon        | Jello     | lemonj@tamu.edu     |
  | Renee        | Rapp      | rr@tamu.edu         |
  | Shakira      | Shakira   | shakira@tamu.edu    |

Scenario: Fetch all admins
    When I go to the 'administrators' path
    Then I should see an admin called 'Al' 'Gorithm'
    And I should see an admin called 'Shrimpfried' 'Rice'
    And I should see an admin called 'Lemon' 'Jello'
    And I should see an admin called 'Renee' 'Rapp'
    And I should see an admin called 'Shakira' 'Shakira'

Scenario: Fetch one admin
    When I go to the admin page for email 'rr@tamu.edu'
    Then I should see an admin called 'Renee' 'Rapp'
    And I should see the 'email' 'rr@tamu.edu'

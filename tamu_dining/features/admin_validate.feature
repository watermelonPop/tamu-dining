Feature: admin validate

  As a software developer,
  So that I can grant higher privileges to some users,
  I want to be able to validate that a user is an administrator through an api call.


Background: admins in database

  Given the following admins exist:
  | first_name   | last_name | email               |
  | Al           | Gorithm   | al_gorithm@tamu.edu |
  | Shrimpfried  | Rice      | shrimprice@tamu.edu |
  | Lemon        | Jello     | lemonj@tamu.edu     |
  | Renee        | Rapp      | rr@tamu.edu         |
  | Shakira      | Shakira   | shakira@tamu.edu    |


Scenario: validate existing admin
        When I go to validate an admin with email 'lemonj@tamu.edu'
        Then I should see 'true'


Scenario: does not validate non-admin
        When I go to validate an admin with email 'nonadmin@tamu.edu'
        Then I should see 'false'


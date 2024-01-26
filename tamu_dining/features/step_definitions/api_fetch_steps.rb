Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      User.create user
    end
end

When /I go to the users path/ do
    visit "/users"
end

Then('I should see a user called {string}') do |name|
    puts "Checking for user: #{name}"
    expect(page).to have_content(name)
end
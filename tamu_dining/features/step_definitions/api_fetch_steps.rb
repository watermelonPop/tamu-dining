Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      User.create user
    end
end

When('I go to the {string} path') do |slash|
    visit "/#{slash}"
end

Then('I should see a user called {string} {string}') do |first, last|
    expect(page).to have_content(first)
    expect(page).to have_content(last)
end

When('I go to the user page for uin {string}') do |uin|
    visit "/users/#{uin}"
end

Then('I should see the {string} {string}') do |field, value|
    response = JSON.parse(page.body)
    expect(response[field].to_s).to eq(value)
  end
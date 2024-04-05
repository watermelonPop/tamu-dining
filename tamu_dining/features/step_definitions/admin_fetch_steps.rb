Given /the following admins exist/ do |admin_table|
        Administrator.destroy_all
        admin_table.hashes.each do |admin|
          Administrator.create admin
        end
end

Then('I should see an admin called {string} {string}') do |first, last|
        expect(page).to have_content(first)
        expect(page).to have_content(last)
end

When('I go to the admin page for email {string}') do |email|
        visit "/administrators/#{email}"
end
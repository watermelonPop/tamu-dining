When('I go to patch user with uin {string} to add {int} credits') do |uin, creds|
    patch "/users/#{uin}/update_credits/#{creds}"
end

Then("I should see {string}") do |expected_response|
    expect(last_response.body).to include(expected_response)
end

Then('user with uin {string} should have {int} credits') do |uin, creds|
    user = User.find_by(uin: uin)
    expect(user.credits).to eq(creds)
end
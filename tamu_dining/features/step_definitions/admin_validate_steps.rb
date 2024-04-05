When('I go to validate an admin with email {string}') do |email|
        get "/administrators/#{email}/validate_admin"
end
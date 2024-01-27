Given('that I {string} user {string} credits by {int}') do |action, uin, num_credits|
  @uin = uin
  visit("/users/#{uin}/#{action}_credits/?credits=#{num_credits}")
end

# Then('I should have {int} credits') do |credits|
#   @user = User.find_by(uin: @uin)
#   expect(@user.credits).to eq (credits)
# end
require_relative 'customer_invitation.rb'

# Filepath, latitude, longitude, range as parameters in order

FILEPATH = 'customer.txt'
OFFICE_LATITUDE = 53.3381985
OFFICE_LONGITUDE = -6.2592576
INVITATION_RANGE = 100

$test_suite_enabled = false

customer_invite = CustomerInvitation.new(FILEPATH, OFFICE_LATITUDE, OFFICE_LONGITUDE, INVITATION_RANGE)

# Getting range of customers within INVITATION_RANGE
customers_to_invite = customer_invite.invite_customers_within_range

# Printing customer name and their user ids
customers_to_invite.each do |cust|
    puts "#{cust.name} #{cust.user_id}"
end

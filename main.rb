require_relative 'customer_invitation.rb'

# Filepath, latitude, longitude, range as parameters in order
CustomerInvitation.new('customer.txt', 53.3381985, -6.2592576, 100).invite_customers_within_range

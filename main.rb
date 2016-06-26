require_relative 'customer_invitation.rb'

# Filepath, latitude, longitude, range as parameters in order
customer_invite = CustomerInvitation.new('customer.txt', 53.3381985, -6.2592576, 100)

customers_to_invite = customer_invite.invite_customers_within_range

customers_to_invite.each do |cust|
    puts "#{cust.name} #{cust.user_id}"
end

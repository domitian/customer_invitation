require_relative 'customer.rb'
require_relative 'txt_to_read.rb'
require_relative 'txt_to_json.rb'

require 'test/unit'

class CustomerInvitation

    def initialize(filepath='customer.txt', source_latitude=53.3381985, source_longitude=-6.2592576, customer_range=100)
        @filepath = filepath
        @source_latitude = source_latitude
        @source_longitude = source_longitude
        @customer_range = customer_range
    end

    def invite_customers_within_range
        input_txt = TxtToRead.read_file(@filepath)
        customer_list = TxtToJson.convert_to_json(input_txt)
        
        customer_objects = create_user_objects(customer_list)
        customers_within_range = get_customers_in_range(customer_objects)
        customers_within_range = customers_within_range.sort
    end

    private

    def create_user_objects customer_list
        customer_list.inject([]) do |customer_objs, customer|
            customer_objs << Customer.new(customer["user_id"], customer["name"], customer["latitude"].to_f, customer["longitude"].to_f)
            customer_objs
        end
    end

    def get_customers_in_range customer_objs
        customer_objs.inject([]) do |invite_list, customer|
            invite_list << customer if customer.get_distance_from_latlong(@source_latitude, @source_longitude) <= @customer_range
            invite_list
        end
    end

end

#CustomerInvitation.new.invite_customers_within_range
class TestCustomerInvitation < Test::Unit::TestCase
    
    def test_invite_customers_within_range
        default_invite = CustomerInvitation.new('test_data/customer.txt', 53.3381985, -6.2592576, 100)
        assert_equal default_invite.invite_customers_within_range.count, 16
    end

end

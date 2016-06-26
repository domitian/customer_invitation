require_relative 'gps_coordinate.rb'

class Customer

    attr_accessor :user_id, :name
    def initialize user_id, name, latitude, longitude
        @user_id = user_id
        @name = name
        @current_location = GpsCoordinate.new(latitude, longitude)
    end

    def get_distance_from_latlong lat, long
        source = GpsCoordinate.new(lat, long)
        @current_location.get_distance_from_source(source)
    end

    def <=> cust
        @user_id <=> cust.user_id
    end

end

#@user = User.new(12, 'Christina Aguilera', 52.986375, -6.043701)
#puts @user.get_distance_from_latlong(53.3381985, -6.2592576)


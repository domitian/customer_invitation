require_relative 'haversine_distance.rb'


class InvalidLatLongRangeException < Exception
end

class GpsCoordinate

    include HaversineDistance

    DEGREES_TO_RADIANS = Math::PI/180
    def initialize (latitude, longitude, scale='degrees')
        if scale == 'degrees'
            raise InvalidLatLongRangeException, "Latitude between -90,90 and longitude between -180,180" if !latlong_in_range(latitude, longitude)
            @latitude = latitude
            @longitude = longitude
        end
    end

    def latlong_in_radians
        [get_coordinate_in_radians(@latitude), get_coordinate_in_radians(@longitude)]
    end

    def get_distance_from_source source
        haversine_distance_in_km(source, self)
    end

    private

    def latlong_in_range lat, long
        lat > -90.0 && lat < 90.0 && long > -180 && long < 180
    end

    def get_coordinate_in_radians degree
        degree * DEGREES_TO_RADIANS
    end

end

if $test_suite_enabled
    require 'test/unit'
    class TestGpsCoordinate < Test::Unit::TestCase
        
        def test_get_distance_from_source
            sour = GpsCoordinate.new(53.3381985, -6.2592576)
            dest = GpsCoordinate.new(52.986375, -6.043701)
            assert_equal dest.get_distance_from_source(sour).to_i, 41
        end

        def test_initialize
            assert_raise(InvalidLatLongRangeException) {
                GpsCoordinate.new(-100,10)
            }
            assert_raise(InvalidLatLongRangeException) {
                GpsCoordinate.new(-10,200)
            }
        end
    end
end

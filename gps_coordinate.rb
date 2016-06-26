require_relative 'haversine_distance.rb'

class GpsCoordinate

    include HaversineDistance

    DEGREES_TO_RADIANS = Math::PI/180
    def initialize (latitude, longitude, scale='degrees')
        if scale == 'degrees'
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

    def get_coordinate_in_radians degree
        degree * DEGREES_TO_RADIANS
    end

end

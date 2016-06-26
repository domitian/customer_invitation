module HaversineDistance

    # Both arguments should be coordinate objects
    EARTH_RADIUS_IN_KM = 6378.4

    def haversine_distance_in_km source, destination
        source_lat_rad, source_long_rad = source.latlong_in_radians
        dest_lat_rad, dest_long_rad = destination.latlong_in_radians

        diff_lat = source_lat_rad - dest_lat_rad
        diff_long = source_long_rad - dest_long_rad

        a = power(Math::sin(diff_lat/2), 2) + Math::cos(source_lat_rad) * Math::cos(dest_lat_rad) * power(Math::sin(diff_long/2), 2)
        great_circle_distance = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

        return EARTH_RADIUS_IN_KM * great_circle_distance
    end

    private

    def power num, pow
        num ** pow
    end

end

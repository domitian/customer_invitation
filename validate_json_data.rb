require 'test/unit'
require 'json'

class String
    
    def valid_float?
        !!Float(self) rescue false
    end

end

module ValidateJsonData

    class InvalidDataTypeException < Exception
    end

    def self.validate json_obj_list
        json_obj_list.each do |obj|
            user_id = obj["user_id"]
            raise InvalidDataTypeException, "user_id for this #{obj.inspect} is invalid" if user_id.to_i.to_s != user_id.to_s

            latitude = obj["latitude"]
            raise InvalidDataTypeException, "latitude for this #{obj.inspect} is invalid" if !latitude.to_s.valid_float?
            longitude = obj["longitude"]
            raise InvalidDataTypeException, "longitude for this #{obj.inspect} is invalid" if !longitude.to_s.valid_float?
        end
    end
    
end

class TestValidateJsonData < Test::Unit::TestCase
    
    def test_validate

        invalid_id = [JSON.parse("{\"latitude\": \"52.986375\", \"user_id\": \"\", \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}")]
        assert_raise(ValidateJsonData::InvalidDataTypeException) {
            ValidateJsonData.validate(invalid_id)
        }

        invalid_lat = [JSON.parse("{\"latitude\": \"\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}")]
        assert_raise(ValidateJsonData::InvalidDataTypeException) {
            ValidateJsonData.validate(invalid_lat)
        }
        
    end
end

require 'json'

require 'test/unit'
module TxtToJson

    class InvalidJsonFormatException < Exception
    end

    def self.convert_to_json txt, separator="\n"
        begin
            txt = txt.to_s
            txt_arr = txt.split(separator)
            return txt_arr.inject([]) do |json_obj, elem|
                json_obj << JSON.parse(elem.to_s)
                json_obj
            end
        rescue JSON::ParserError => e
            raise InvalidJsonFormatException, 'File format is not valid json'
        end
    end

end

#puts TxtToJson.convert_to_json(File.read('test_data/invalid_json'))
class TestTxtToJson < Test::Unit::TestCase

    def test_convert_to_json
        # invalid json format
        assert_raise(TxtToJson::InvalidJsonFormatException) {
            TxtToJson.convert_to_json File.read('test_data/invalid_json')
        }
    end

end

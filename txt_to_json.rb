require 'json'

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
        rescue JSON::ParseError => e
            raise InvalidJsonFormatException, 'File format is not valid json'
        end
    end

end

#puts TxtToJson.convert_to_json(File.read('customer.txt'))

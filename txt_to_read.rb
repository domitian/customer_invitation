module TxtToRead

    # Creating custom exceptions
    class FileNotFoundException < Exception
    end

    class FileAccessException < Exception
    end

    def self.read_file file_path
        begin
            return File.read(file_path.to_s)
        rescue Errno::ENOENT => e
            raise FileNotFoundException, e.msg
        rescue Errno::EACCES => e
            raise FileAccessException, e.msg
        end
    end

end


require 'test/unit'
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
            raise FileNotFoundException, e.message
        rescue Errno::EACCES => e
            raise FileAccessException, e.message
        end
    end

end

class TestTxtToRead < Test::Unit::TestCase
    
    def test_read_file
        # nil file name
        assert_raise(TxtToRead::FileNotFoundException) {
            TxtToRead.read_file(nil)
        }
        # dummy file name
        assert_raise(TxtToRead::FileNotFoundException) {
            TxtToRead.read_file('dummy')
        }
        assert_raise(TxtToRead::FileAccessException) {
            TxtToRead.read_file('test_data/noperm')
        }
        assert_equal TxtToRead.read_file('test_data/empty_file'), ''
        assert_equal TxtToRead.read_file('test_data/empty_file'), File.read('test_data/empty_file')
    end

end

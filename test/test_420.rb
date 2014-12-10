require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'minitest/autorun'
require '420'

class FTTest < Minitest::Test
    # Run a test from early morning.
    def test_morning
        assert_equal "1 hours and 5 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "3:15:30"])
    end

    # Run a test from noon
    def test_noon
        assert_equal "4 hours and 20 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "12:00:30"])
    end

    # Run a test from night
    def test_night
        assert_equal "7 hours and 50 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "20:30:30"])
    end

    # Run a test from 4:05am/pm and 4:45am/pm
    def test_4
        assert_equal "15 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "4:05"])
        assert_equal "11 hours and 35 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "4:45"])
        assert_equal "15 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "16:05"])
            assert_equal "11 hours and 35 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "16:45"])
    end


    # Run a test from 4:20am/pm
    def test_420
        assert_equal "Happy 4:20!",
            FourTwenty.run_from_time(["time", "4:20:00"])
        assert_equal "Happy 4:20!",
            FourTwenty.run_from_time(["time", "16:20:30"])
    end

    # Make sure the minutes aren't getting rounded up
    def test_seconds
        assert_equal "4 hours and 20 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "12:00:45"])
        assert_equal "4 hours and 20 minutes until 4:20!",
            FourTwenty.run_from_time(["time", "12:00:0"])
    end



end


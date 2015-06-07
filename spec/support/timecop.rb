require "timecop"

def at_a_fixed_time(&block)
  Timecop.freeze Time.utc(2015, 5, 31, 22, 55, 0), &block
end

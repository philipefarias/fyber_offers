require "timecop"

def at_a_fixed_time(&block)
  Timecop.freeze Time.local(2015, 5, 31, 19, 55, 0), &block
end

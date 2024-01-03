#!/usr/bin/env ruby
puts ARGV[0].scan(/([0-9]{11}|[\+0-9]{12}|(?!:)[\-\d\:]{13})/).join(",")

#!/usr/bin/env ruby
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: sorter [options] UNSORTED"

  opts.on("-v", "--reverse", "Run verbosely") { |v| options[:reverse] = v }
end.parse!


if options[:reverse]
    puts ARGF.each_line.sort.reverse
else
    puts ARGF.each_line.sort
end
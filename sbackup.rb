#!/usr/bin/env ruby

require 'pp'
require './optparser'

class SBackup
    Version = [0, 1, 'alpha']
end

options = OptParser.parse(ARGV)
pp options
pp ARGV

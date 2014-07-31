#!/usr/bin/env ruby

require 'pp'
require './optparser'
require './config_file'

class SBackup
    Version = [0, 1, 'alpha']

    config = ConfigFile.new("/home/baran/baran/config.yml")

    options = OptParser.parse(ARGV)
    cfg = config.get_config("simple").merge! options.to_h.inject({}) { |mem, (k,v)| mem[k.to_s] = v; mem}

    option = {:gzip => {:param => "z", :mime_type => "gz"},
				:bzip2 => {:param => "j", :mime_type => "bz2"}}

	method = cfg["compression"]
	# Fire!
    `tar cv#{option[method.to_sym][:param]}f #{cfg["destination"]}backup.tar.#{option[method.to_sym][:mime_type]} #{cfg["directories"].join(" ")}`
end
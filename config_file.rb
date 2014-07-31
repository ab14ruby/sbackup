require 'yaml'

class ConfigFile

	attr_reader :cfg_file

	def initialize(config_file)
		@cfg_file = config_file
	end

	def load
		YAML::load(File.open("#{@cfg_file}"))
	end

	def get_config(backup_type)
		if backup_type.eql? "default"
			load()["default"]
	    else
			load()[backup_type]
	    end
    end
end

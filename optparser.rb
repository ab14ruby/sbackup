require 'optparse'
require 'ostruct'
require 'pp'

class OptParser
    def self.parse(args)
        options = OpenStruct.new
        options.compression_method = false
        options.verbose = false

        op = OptionParser.new do |opts|
            opts.banner = "Usage: sbackup.rb [options]"

            opts.separator ""
            opts.separator "Options:"

            opts.on("-v", "--verbose", "Verbosely list files processed") do |v|
                options.verbose = v
            end

            opts.on("--compress [METHOD]", [:gzip, :bzip2, :zip],
                    "Select compression method (gzip, bzip2, or zip)") do |method|
                options.compression_method = method
            end

            opts.on_tail("-h", "--help", "Show help message") do |h|
                puts opts
                exit
            end

            opts.on_tail("--version", "Show version") do
                puts SBackup::Version.join('.')
                exit
            end
        end

        begin
        op.parse!(args)
        options
        rescue OptionParser::InvalidOption => e
            puts e
            puts op
            exit 1
        rescue OptionParser::InvalidArgument => e
            puts e
            puts op
            exit 1
        end
    end
end

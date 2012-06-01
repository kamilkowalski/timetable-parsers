require 'nokogiri'
require 'open-uri'

class Timetabler
	def initialize
		@lines  = []
		@routes = []
		@stops  = []
		@times  = []
	end

	def parsers
		Dir.entries(File.join(File.dirname(__FILE__), "parsers")).select{|f| !["..", "."].include?(f)}
	end

	def fetch(parser)
		if parsers.include? parser
			require File.join(File.dirname(__FILE__), "parsers", parser, "parser")
			subinitialize
			fetch_all
		else
			nil
		end
	end
end

class Timetabler::Line < Hash

end

class Timetabler::Route < Hash

end

class Timetabler::Stop < Hash

end

class Timetabler::Time < Hash

end
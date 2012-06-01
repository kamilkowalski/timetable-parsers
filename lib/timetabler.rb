require 'nokogiri'
require 'open-uri'

class Timetabler
	def initialize(parser=nil)
		@lines  = []
		@routes = []
		@stops  = []
		@times  = []

		@parser = parser

		if !@parser.nil?
			use_parser @parser
		end
	end

	def parsers
		Dir.entries(File.join(File.dirname(__FILE__), "parsers")).select{|f| !["..", "."].include?(f)}
	end

	def fetch(parser=nil)
		if @parser.nil? and parser.nil?
			raise "Parser not specified"
		elsif @parser.nil? and !parser.nil?
			use_parser parser
		end
		
		fetch_all
	end

	def use_parser(parser)
		if parsers.include? parser
			require File.join(File.dirname(__FILE__), "parsers", parser, "parser")
			subinitialize
		else
			raise "Unknown parser: " + parser.to_s
		end

		return self
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
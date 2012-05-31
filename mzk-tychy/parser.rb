require 'nokogiri'
require 'open-uri'

line_list = Nokogiri::HTML(open('http://www.mzk.pl/rozklady/?co=lista_linii'))

puts "Linie:"

lines = line_list.css('ul.linie_typu a').select{|l| l.content.length <= 5}

lines.each do |link|
  puts link.content.gsub(/\*/, "")
end

puts "\n\nPrzystanki:"

lines.each do |link|
	line = Nokogiri::HTML(open('http://www.mzk.pl/rozklady/'+link['href']))

	puts "\nPrzystanki linii " + link.content.gsub(/\*/, "") + ":"

	line.css("div#trasy div.trasa").each do |route|
		puts "Trasa w kierunku " + route.css("h4 span").first.content

		route.css("ul li a").each do |stop|
			puts stop.content.strip
		end

		puts "\n"
	end
end
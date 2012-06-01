class Timetabler
	def subinitialize
		# Used for temporary route storage since we would have to load the same page twice to get the times and routes
		@route_nodes = []
	end

	def fetch_all
		{:lines => fetch_lines, :routes => fetch_routes, :stops => fetch_stops}
	end

	def fetch_lines
		line_list = Nokogiri::HTML(open('http://www.mzk.pl/rozklady/?co=lista_linii'))

		lines = line_list.css('ul.linie_typu a').select{|l| l.content.length <= 5}

		@lines = lines.map{ |link|
			l = Timetabler::Line.new
			l[:name] = link.content.gsub(/\*/, "")
			l[:href] = link[:href]

			l
		}
	end

	def fetch_routes
		if @lines.nil?
			fetch_lines
		end

		@lines.each_index do |id|
			link = @lines[id]

			line = Nokogiri::HTML(open('http://www.mzk.pl/rozklady/'+link[:href]))
			line.css("div#trasy div.trasa").each do |route|
				r = Timetabler::Route.new
				r[:line_id] = id;
				r[:name] = route.css("h4 span").first.content

				@routes << r
				@route_nodes << route
			end
		end

		return @routes
	end

	def fetch_stops

		if @routes.nil? or @route_nodes.nil?
			fetch_routes
		end

		@route_nodes.each_index do |id|
			route = @route_nodes[id]

			route.css("ul li a").map{|stop|
				s = Timetabler::Stop.new
				s[:line_id] = @routes[id][:line_id]
				s[:route_id] = id
				s[:name] = stop.content.strip
				s[:href] = stop[:href]

				@stops << s
			}
		end

		return @stops
	end
end
Gem::Specification.new do |s|
	s.name        = 'timetabler'
	s.version     = '0.1.0'
	s.summary     = 'A public transportation timetable parser'
	s.description = 'Timetabler is a Polish public transportation timetable parser that allows you to extract bus schedules directly from websites in a code-friendly format.'

	s.required_ruby_version = '>= 1.9.2'
	
	s.license  = 'MIT'
	s.author   = 'Kamil Kowalski'
	s.email    = 'kowalski.tychy@gmail.com'
	s.homepage = 'https://github.com/kamilkowalski/timetable-parsers'

	s.add_dependency('nokogiri',   '>= 1.5.2')
end
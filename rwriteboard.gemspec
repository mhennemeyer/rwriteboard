Gem::Specification.new do |s|
  s.name     = "rwriteboard"
  s.version  = "0.1.2"
  s.date     = "2008-11-15"
  s.summary  = "Interface to writeboard"
  s.email    = "mhennemeyer@gmail.com"
  s.homepage = "http://github.com/mhennemeyer/rwriteboard"
  s.description = "RWriteboard is used to fetch and post writeboard contents"
  s.has_rdoc = false
  s.authors  = ["Matthias Hennemeyer"]
  s.files    = [ 
		"README",  
		"rwriteboard.gemspec", 
		"lib/rwriteboard.rb", 
		"lib/string_extension.rb"]
  s.test_files = ["spec/rwriteboard_spec.rb", 
      "spec/string_extension_spec.rb"]
end
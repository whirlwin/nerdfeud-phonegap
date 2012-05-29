#!/usr/lib/ruby

require 'haml'

Dir.glob '**/*' do |haml_file|
  if (File.extname(haml_file) == '.haml')
    puts 'Converting Haml to HTML: ' + haml_file    
    File.write(
        haml_file.sub(/(.)\.haml/, '\1.html'),
        Haml::Engine.new(File.open(haml_file).read).render)
  end
end

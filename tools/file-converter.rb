#!/usr/lib/ruby

require 'coffee-script'
require 'haml'

Dir.glob '**/*' do |haml_file|
  case File.extname haml_file
  when '.coffee'
    puts "Converting #{haml_file} to JavaScript"
  when '.haml'
    puts "Converting #{haml_file} to HTML"
  end
end

def write_to_file(file_name, contents)
  File.write()
end

=begin
  if 1==1 exit
  if (File.extname(haml_file) =~ /\.haml/)
    puts 'Converting Haml to HTML: ' + haml_file    
    File.write(
        haml_file.sub(/(.)\.haml/, '\1.html'),
        Haml::Engine.new(File.open(haml_file).read).render)
  end
end
=end

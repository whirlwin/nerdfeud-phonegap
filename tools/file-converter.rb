#!/usr/lib/ruby

################################################################################
#                                                                              #
#                                                                              #
################################################################################

require 'coffee-script'
require 'haml'

file_exts = { 'haml' => 'html', 'coffee'=> 'js' }

puts file_exts['haml']

def fwrite(name, contents)
end

Dir.glob '**/*' do |haml_file|
  case File.extname haml_file
  when '.coffee'
    puts "Converting #{haml_file} to JavaScript"
  when '.haml'
    puts "Converting #{haml_file} to HTML"
    fwrite haml_file, Haml::Engine.new(File.open(haml_file).read).render
  end
end





=begin
  if (File.extname(haml_file) =~ /\.haml/)
    puts 'Converting Haml to HTML: ' + haml_file    
    File.write(
        haml_file.sub(/(.)\.haml/, '\1.html'),
        Haml::Engine.new(File.open(haml_file).read).render)
  end
end
=end

#!/usr/lib/ruby

################################################################################
#                                                                              #
# This script converts Haml and CoffeeScript to HTML and JavaScript            #
#                                                                              #
################################################################################

require 'coffee-script'
require 'haml'

$file_exts = { 'haml' => 'html', 'coffee' => 'js' }

def fwrite(name, contents)
  name.scan /(.+)\.(.+)/ do |base, orig_ext|
    new_ext = $file_exts[orig_ext]
    puts "Converting #{name} to #{new_ext}"
    File.write("#{base}.#{new_ext}", contents)
  end
end

Dir.glob '**/*' do |file|
  case File.extname file
  when '.coffee'
    fwrite file, CoffeeScript.compile(File.read(file))
  when '.haml'
    fwrite file, Haml::Engine.new(File.read(file)).render
  else
    next
  end
end

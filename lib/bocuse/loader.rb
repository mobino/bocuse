module Bocuse
  
  # This is used to discover bocuse configuration files.
  #
  class Loader
    
    def load name
      filename = ::File.expand_path "config/nodes/#{name}.rb", Dir.pwd
      file = Bocuse::File.new
      file.load filename
    end
    
  end
  
end
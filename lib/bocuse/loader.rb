module Bocuse
  
  # This is used to discover bocuse configuration files.
  #
  class Loader
    
    # Loads the given node.
    #
    # TODO It should load all nodes, presumably?
    #
    def load name
      filename = ::File.expand_path "config/nodes/#{name}.rb", Dir.pwd
      file = Bocuse::File.new
      file.load filename
    end
    
  end
  
end
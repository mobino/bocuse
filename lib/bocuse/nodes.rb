module Bocuse
  
  # Discovery class for nodes.
  #
  # Note: Caches configurations of found nodes.
  #
  class Nodes
    
    # TODO Make an instance?
    #
    class << self
      
      # Add a node to the cache.
      #
      def put name, configuration
        @nodes ||= {}
        @nodes[name] = configuration
      end
    
      # Return all nodes.
      #
      # Note: File.evaluate_all tries to load all nodes.
      #
      def all directory=nil
        @nodes || File.evaluate_all(directory) && @nodes || []
      end
      
      # Clear the cache.
      #
      def clear
        @nodes = nil
      end

      # Loads all node descriptions and searches for a pattern or a given node
      # by name. 
      # 
      # @overload find(anything)
      #   Finds a node taking the current directory as base project directory. 
      #   @param anything [#===] node pattern or name to look for
      #   @return [Hash<name,configuration>] a name,configuration map
      # @overload find(anything, directory)
      #   Finds a node in a given project directory.
      #   @param anything [#===] node pattern or name to look for
      #   @param directory [String] bocuse project directory
      #   @return [Hash<name,configuration>] a name,configuration map
      #
      #
      def find anything, directory=nil
        result = {}
        all(directory).each do |name, configuration|
          result[name] = configuration if anything === name
        end
        result
      end
      
    end
    
  end
  
end
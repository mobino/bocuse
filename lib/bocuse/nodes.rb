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
      def all
        @nodes || File.new.evaluate_all && @nodes || []
      end
      
      # Clear the cache.
      #
      def clear
        @nodes = nil
      end
    
      # Pass in any String#=== comparable object.
      #
      # Returns a Hash of { name => configuration }
      #
      def find anything
        result = {}
        all.each do |name, configuration|
          result[name] = configuration if anything === name
        end
        result
      end
      
    end
    
  end
  
end
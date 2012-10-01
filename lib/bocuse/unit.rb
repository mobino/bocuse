module Bocuse
  # A configuration unit. 
  #
  class Bocuse::Unit
    # Returns the current configuration, but only during a call to this unit. 
    attr_reader :current_configuration
    
    def initialize(block, context)
      @block = block
      @context = context
    end
    
    def call(configuration)
      @current_configuration = configuration
      
      # Fill in the config hash argument if the block cares at all.
      instance_exec(configuration, &@block)
    ensure 
      @current_configuration = nil
    end
    
    # Cook adds to the toplevel recipes of this file's configuration.
    #
    def cook recipe, &block
      current_configuration.recipes << recipe
      current_configuration.send(recipe, &block)
    end
    
    # Make the given module a helper module for this node. 
    #
    def helper_module(mod)
      extend mod
    end
  
    # Include the given template name.
    #
    # Note: This could be pushed to the configuration.
    #
    def include_template identifier
      template_block = @context.template identifier

      template_block.call(current_configuration)
    end
    
    # Exposes some of bocuses internal variables to the node that is currently
    # compiled. This allows using node name (, etc...) for formulating clever
    # node configurations.
    #
    def bocuse
      @context.bocuse
    end
  end
end
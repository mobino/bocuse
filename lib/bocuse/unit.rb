module Bocuse
  # A configuration unit. 
  #
  class Bocuse::Unit
    def initialize(block, project)
      @block = block
      @project = project
    end
    
    def call(configuration, context)
      @configuration = configuration
      @context = context
      
      # Fill in the config hash argument if the block cares at all.
      instance_exec(configuration, &@block)
    ensure 
      @configuration = nil
      @context = nil
    end
    
    # Cook adds to the toplevel recipes of this file's configuration.
    #
    def cook recipe, &block
      @configuration.recipes << recipe
      @configuration.public_send(recipe, &block)
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
      template_block = @project.lookup_template identifier

      template_block.call(@configuration, @context)
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
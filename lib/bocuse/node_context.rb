module Bocuse
  # A context for a node. This wraps the project level context and provides 
  # node specific context functions. 
  #
  class NodeContext
    def initialize(node_name, context)
      @context = context
      @node_name = node_name
    end

    # Method delegation to the context of this context. Every method not 
    # defined here may be defined there instead. 
    #
    def respond_to?(sym)
      super || @context.respond_to?(sym)
    end
    def method_missing(sym, *args, &block)
      return @context.send(sym, *args, &block) if @context.respond_to?(sym)
      super
    end
    
    def bocuse
      @context.bocuse.merge(node_name: @node_name)
    end
  end
end
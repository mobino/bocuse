require 'bocuse/context_delegation'

module Bocuse
  # A context for a node. This wraps the project level context and provides 
  # node specific context functions. 
  #
  class NodeContext
    include ContextDelegation
    
    def initialize(node_name, context)
      @context = context
      @node_name = node_name
    end
    
    def bocuse
      @context.bocuse.merge(node_name: @node_name)
    end
  end
end
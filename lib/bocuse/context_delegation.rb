module Bocuse
  module ContextDelegation
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
  end
end
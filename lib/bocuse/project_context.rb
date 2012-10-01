require 'bocuse/context_delegation'

module Bocuse
  # Project wide evaluation context. 
  #
  class ProjectContext
    include ContextDelegation
    
    def initialize project
      @context = @project = project
    end
    
    # @see Project#lookup_template
    #
    def template name 
      @project.lookup_template(name)
    end
    
    def bocuse
      {}
    end
  end
end
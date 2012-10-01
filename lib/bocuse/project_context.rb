require 'bocuse/context_delegation'

module Bocuse
  # Project wide evaluation context. 
  #
  class ProjectContext
    def initialize
    end
    
    def bocuse
      {}
    end
  end
end
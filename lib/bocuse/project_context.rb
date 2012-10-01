
require 'hashie/mash'

require 'bocuse/context_delegation'

module Bocuse
  class ContextHash < Hashie::Mash
  end
  
  # Project wide evaluation context. 
  #
  class ProjectContext
    def initialize
    end
    
    def bocuse
      ContextHash.new
    end
  end
end
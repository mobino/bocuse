module Bocuse

  # This is a value object that by default starts out
  # life as not having decided what exactly it is.
  #
  # On first adding another object, it assumes an internal
  # form.
  #
  # It will complain if its internal form does not
  # correspond to the assumed external one, ie.
  # when you want to << something, but it has already
  # assumed the internal form of a hash (<< does not
  # exist on a hash).
  #
  # Note to next developer:
  # Delegations are explicitly stated.
  # Did not want to pull in active support prematurely.
  #
  class Value
    
    def initialize internal = nil
      @internal = internal
    end
    
    def []= key, value
      @internal ||= {}
      @internal[key] = value
    end
    
    def << element
      @internal ||= []
      @internal << element
    end
    
    def to_h
      @internal
    end
    
  end
  
end
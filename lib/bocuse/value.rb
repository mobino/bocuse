module Bocuse

  # This is a value object that by default starts out life as not having
  # decided what exactly it is.
  #
  # On first adding another object, it assumes an internal form.
  #
  # It will complain if its internal form does not correspond to the assumed
  # external one, ie. when you want to << something, but it has already
  # assumed the internal form of a hash (<< does not exist on a hash).
  #
  class Value
    
    module Empty; def self.empty?; true; end end
    
    def initialize internal = Empty
      @internal = internal
    end
    
    def empty?
      @internal && @internal.empty?
    end
    
    def []= key, value
      @internal = {} if empty?
      @internal[key] = value
    end
    
    def << element
      @internal = [] if empty?
      @internal << element
    end
    
    def to_h
      @internal unless Empty == @internal
    end
    
    def dup
      Value.new(@internal.dup)
    end
  end
  
end
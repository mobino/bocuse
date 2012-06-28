module Bocuse
  
  # This is the core class of bocuse.
  #
  # Its functions are:
  #  * to be able to spit out a configuration hash when prompted.
  #  * to be configurable
  #
  # It will mainly return proxies that will lodge themselves
  # in its internal hash. The proxies usually represent an
  # internal hash value.
  #
  class Configuration
    
    attr_reader :store,
                :unresolved_block
    
    def initialize &unresolved_block
      @store = {}
      @unresolved_block = unresolved_block
    end
    
    # Explicit accessor.
    #
    def [] key
      value = @store[key] || Value.new
      value.to_h
    end
    
    def __resolve__
      if unresolved_block
        self.instance_eval &unresolved_block
        unresolved_block = nil
      end
    end
    
    # The main method.
    #
    # It will react to method calls, install the right keys
    # on the internal store and return proxies on
    # which callers can perform operations, e.g. <<.
    #
    # Note: The user only interacts with Values and Configurations.
    # Not with the internal values.
    #
    # Except when the user explicitly takes the
    # values out using [].
    #
    def method_missing name, *args
      case args.size
      when 0
        if block_given?
          subconfig = Configuration.new &Proc.new
          store[name] = subconfig
        else
          store[name] || Value.new
        end
      when 1
        store[name] = Value.new args.first
      end
    end
    
    # Returns a configuration hash.
    #
    # Note: Resolves any unresolved blocks.
    #
    # Note: Call to_json on this to get a JSON
    # representation of the hash.
    #
    def to_h
      __resolve__ # TODO Resolve it using the copy, not the original store.
      copy = store.dup
      copy.each do |key, value|
        copy[key] = value.to_h
      end
      copy
    end
    
  end
  
end
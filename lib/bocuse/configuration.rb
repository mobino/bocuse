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
    
    def initialize
      @store = {}
      instance_eval(&Proc.new) if block_given?
    end
    
    # Explicit accessor for POROs.
    #
    # Note: Unwraps Values.
    #
    def [] key
      value = @store[key]
      value.to_h rescue value
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
          store[name] ||= Value.new # Note: You will add a value to the config if you get one out. Use it!
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
      copy = {}
      store.each do |key, value|
        value = value.to_h
        copy[key] = value if value
      end
      copy
    end
    
  end
  
end
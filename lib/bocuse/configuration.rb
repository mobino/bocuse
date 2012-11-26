require 'blankslate'

module Bocuse
  
  # This is the core class of bocuse.
  #
  # Its functions are:
  #  * to be able to spit out a configuration hash when prompted.
  #  * to be configurable
  #
  # It will mainly return proxies that will lodge themselves in its internal
  # hash. The proxies usually represent an internal hash value.
  #
  class Configuration < BlankSlate
    
    reveal :respond_to?
    reveal :public_send
    
    attr_reader :store,
                :unresolved_block
    
    def initialize(hash=nil, &block)
      @store = hash && hash.dup || Hash.new
      
      call(block) if block
    end
    
    # Explicit accessor for POROs.
    #
    # Note: Unwraps Values.
    #
    def [] key
      value = @store[key]
      value.to_h rescue value
    end
    
    # Sets key to value. 
    #
    def []= key, value
      @store[key] = value
    end
        
    # The main method.
    #
    # It will react to method calls, install the right keys on the internal
    # store and return proxies on which callers can perform operations, e.g.
    # <<.
    #
    # Note: The user only interacts with Configurations. Not with the internal
    # values.
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
          store[name] ||= Value.new 
        end
      when 1
        store[name] = Value.new args.first
      end
    end
    
    # Returns a configuration hash.
    #
    # NOTE: Resolves any unresolved blocks.
    #
    # NOTE: Call to_json on this to get a JSON representation of the hash.
    #
    def to_h
      copy = {}
      store.each do |key, value|
        value = value.to_h if value.respond_to?(:to_h)
        copy[key] = value if value
      end
      copy
    end
    
    # Performs a deep duplication of this configuration object. This is mainly
    # used by the user for quickly generating a lot of copies of a template.
    # 
    def dup(&block)
      dup_cfg = Configuration.new

      store.each do |key, value|
        dup_cfg[key] = value.dup
      end

      dup_cfg.call(block) if block
      dup_cfg
    end
    
    # Executes the block such that it may modify this object. 
    #
    def call(block)
      fail ArgumentError unless block

      block.call(self) if block.arity>0
      instance_eval(&block) if block.arity == 0
    end
  end
  
end
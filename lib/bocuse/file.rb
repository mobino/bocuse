# Represents a bocuse File. 
#
# This is usually a file that contains one or more of the
# following directives:
#  * node
#  * template
#
# It is used to generate a config hash from the given files.
#
class Bocuse::File
  attr_reader :path

  # When inside a construct that has a configuration associated, this will 
  # return that configuration instance.
  attr_reader :current_configuration
  
  def initialize(path, context)
    @path = path
    @context = context
  end
      
  # Returns a config hash.
  #
  # Call to_h on the returned configuration to
  # get the config hash.
  #
  # Will return nil if there is no configuration
  # to speak of inside the file. Use "node" or
  # "template" to define a configuration.
  #
  def evaluate
    ::File.open path, 'r' do |file|
      self.instance_eval file.read, file.path
    end
  end
  
  # Include the given template name.
  #
  # Note: This could be pushed to the configuration.
  #
  def include_template identifier
    template = @context.template identifier

    # Note: Template is dupped to avoid evaluating the original.
    #
    current_configuration.merge! template.dup
  end
  
  # Make the given module a helper module for this node. 
  #
  def helper_module(mod)
    extend mod
  end
  
  # The files read by #evaluate will trigger these methods.
  #
  def node name
    configuration_block do |configuration|
      yield configuration
      @context.register_node name, configuration
    end
  end
  def template
    configuration_block do |configuration|
      yield configuration
      @context.register_template path, configuration
    end
  end
  
  # Cook adds to the toplevel recipes of this file's configuration.
  #
  def cook recipe
    __configuration__.recipes << recipe
  end
  
private
  def configuration_block
    # NOTE since thread-safety is not an issue here (who would use threads to
    # define configuration?), we can use a simple file-global state to keep
    # track of which configuration is in progress. We use the begin-end
    # construct to make sure that configurations are not used beyond the end
    # of the node block. 

    configuration = @current_configuration = Bocuse::Configuration.new
    
    begin
      yield configuration
    ensure
      @current_configuration = nil
    end
    
    configuration
  end
end
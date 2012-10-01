
require 'bocuse/node_context'

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
  # Call to_h on the returned configuration to get the config hash.
  #
  # Will return nil if there is no configuration to speak of inside the file.
  # Use "node" or "template" to define a configuration.
  #
  def evaluate
    ::File.open path, 'r' do |file|
      self.instance_eval file.read, file.path
    end
  end

  # The files read by #evaluate will trigger these methods.
  #
  def node name
    node_context = Bocuse::NodeContext.new(name, @context)
    configuration = Bocuse::Configuration.new

    unit = Bocuse::Unit.new(Proc.new, node_context)
    unit.call(configuration)

    @context.register_node name, configuration
    
    return configuration
  end
  def template
    # Delay template evaluation until someone tries to call include_template.
    # At that time, we'll have a configuration object to have the template
    # manipulate. 
    unit = Bocuse::Unit.new(Proc.new, @context)
    @context.register_template path, unit
    unit
  end
end
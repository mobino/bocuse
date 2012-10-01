
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

  def initialize(path, project, context)
    @path = path
    @project = project
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

    unit = Bocuse::Unit.new(Proc.new, @project, node_context)
    unit.call(configuration)

    @project.register_node name, configuration
    
    return configuration
  end
  def template
    # Delay template evaluation until someone tries to call include_template.
    # At that time, we'll have a configuration object to have the template
    # manipulate. 
    unit = Bocuse::Unit.new(Proc.new, @project, @context)
    @project.register_template path, unit
    unit
  end
end
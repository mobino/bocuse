# Represents a bocuse File.
#
# This is usually a file that contains one of the
# following directives:
#  * node
#  * template
#
# It is used to generate a config hash from the given files.
#
class Bocuse::File
      
  def __configuration__
    @configuration ||= Bocuse::Configuration.new
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
  def evaluate filename
    ::File.open filename, 'r' do |file|
      self.instance_eval file.read, file.path
    end
    __configuration__
  end
  
  # Evaluates all files.
  #
  # Retrieve the found configurations via
  #   Nodes.find pattern_or_name
  #
  # @param dir [String] directory to use as project base directory
  # @return [void]
  #
  def self.evaluate_all dir=nil
    project_path = dir || ::File.expand_path('config', Dir.pwd)
    nodes_path = ::File.join(project_path, 'nodes')
    
    # Make sure that project libraries can be loaded: 
    $:.unshift ::File.join(project_path, 'lib')
    
    Dir[::File.join(nodes_path, '**', '*.rb')].each do |filename|
      new.evaluate filename
    end
  end
  
  # Include the given template name.
  #
  # Note: This could be pushed to the configuration.
  #
  def include_template identifier
    template = Bocuse::Templates.get identifier.to_sym
    
    # Note: Template is dupped to avoid evaluating the original.
    #
    __configuration__.merge! template.dup
  end
  
  # Make the given module a helper module for this node. 
  #
  def helper_module(mod)
    extend mod
  end
  
  # The files read by #evaluate will trigger these methods.
  #
  def node name = nil
    yield __configuration__
    Bocuse::Nodes.put name, __configuration__ # Note: Cache this node.
    __configuration__
  end
  def template name = nil
    yield __configuration__
    __configuration__
  end
  
  # Cook adds to the toplevel recipes of this file's configuration.
  #
  def cook recipe
    __configuration__.recipes << recipe
  end
  
end
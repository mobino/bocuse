module Bocuse
  # A bocuse project comes in two flavours: simple and co-located with chef.
  # The simple project is a directory with the subdirectories 
  #   nodes/
  #   templates/
  #   lib/
  #
  # The nodes/ subdirectory contains all node descriptions, templates/
  # contains templates and lib/ is added to the load path and can contain code
  # to help with construction of the configuration. 
  #
  # When you co-host bocuse with chef, normally you would store all these
  # directories one level deeper. Here's what your hierarchy should look like
  # in this case: 
  # 
  #   config/
  #     nodes/
  #     templates/
  #     lib/
  #
  class Project
    attr_reader :base_path
        
    # Initialize a bocuse project by specifying its base directory. 
    #
    def initialize(base_directory=nil)
      base_directory = base_directory || Dir.pwd
        
      if chef_cohosted?(base_directory)
        base_directory = File.join(base_directory, 'config')
      end
      
      @base_path = Pathname.new(base_directory)
    end
    
    # Returns a Bocuse::Unit constructed with the file pointed to by path. If
    # the path doesn't start with a ?/, it is interpreted as being relative to
    # the base directory.
    #
    def unit(path)
      path = Pathname.new(path)
      
      return Bocuse::Unit.new(path) if path.absolute?
      return Bocuse::Unit.new(
        base_path.join(path))
    end
    
    # Evaluates a file given by path. 
    #
    def evaluate(path)
      unit(path).evaluate
    end
    
    # Evaluates all files in the project.
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
    
    class << self # CLASS METHODS
      def bocuse_path?(path)
        %w(nodes).all? { |el| 
          File.directory?(File.join(path, el)) }
      end
    end
    
  private
    def chef_cohosted?(base)
      !self.class.bocuse_path?(base) && 
        self.class.bocuse_path?(File.join(base, 'config'))
    end
  end
end
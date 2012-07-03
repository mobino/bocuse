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
        base_directory = ::File.join(base_directory, 'config')
      end
      
      @base_path = Pathname.new(base_directory)
      @templates = Hash.new
      @nodes     = Hash.new
    end
    
    def file path
      path = Pathname.new(path)
      path = base_path.join(path) unless path.absolute?
      
      Bocuse::File.new(path, self)
    end
    
    # Evaluates a file given by path. 
    #
    # @param path [String] file path, either absolute or relative to project
    #   base directory
    # @return [void]
    #
    def evaluate path
      file(path).evaluate(self)
    end
    
    # Registers a template for project usage. 
    #
    def register_template name, template
      @templates.store name, template
    end
    
    # Returns a template by name.
    #
    def template name
      @templates.fetch name
    end
    
    # Registers a machine node in the project. 
    #
    def register_node name, node
      @nodes.store name, node
    end
    
    # Returns all nodes in this project as a hash. 
    #
    # @return [Hash<name,Configuration>] A hash mapping node names to their
    #   configuration objects.
    #
    def nodes
      evaluate_all
      @nodes
    end
    
    # Evaluates all files in the project.
    #
    # Retrieve the found configurations via
    #   Nodes.find pattern_or_name
    #
    # @param dir [String] directory to use as project base directory
    # @return [void]
    #
    def evaluate_all
      nodes_path = base_path.join('nodes')

      # Make sure that project libraries can be loaded: 
      lib_dir = base_path.join('lib')
      $:.unshift lib_dir if ::File.directory?(lib_dir)

      Dir[nodes_path.join('**', '*.rb')].each do |filename|
        file(filename).evaluate
      end
    end
    
    class << self # CLASS METHODS
      def bocuse_path?(path)
        %w(nodes).all? { |el| 
          ::File.directory?(::File.join(path, el)) }
      end
    end
    
  private
    def chef_cohosted?(base)
      !self.class.bocuse_path?(base) && 
        self.class.bocuse_path?(::File.join(base, 'config'))
    end
  end
end
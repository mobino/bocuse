require 'pathname'

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
  # This class does most of the base path handling and of the path
  # manipulation. 
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
      
      # Make sure that project libraries can be loaded: 
      lib_dir = base_path.join('lib')
      $:.unshift lib_dir if ::File.directory?(lib_dir)
    end
    
    # Returns one of the projects files as a {File}.
    #
    # @param path [String] a relative or absulute file path 
    # @return [File] file at path below the project directory
    #
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
      file(path).evaluate
    end
    
    # Registers a template for project usage. 
    #
    def register_template path, template
      path = path.to_s
      template_base = base_path.join('templates/').to_s
      
      # Is this template path below base_path?
      if path.start_with?(template_base)
        path = path[template_base.size..-1]
      end
      
      # Does the path end in .rb? (most will)
      if path.end_with?('.rb')
        path = path.slice 0..-4
      end

      @templates.store path.to_sym, template
    end
    
    # Returns a template by name. Official template names can be either
    # absulute paths or relative paths to template files, but do NOT end in
    # .rb. 
    # 
    #   foo               -> templates/foo.rb
    #   /templates/bar    -> /usr/templates/bar.rb
    #
    def template name
      unless @templates.has_key?(name.to_sym)
        file_name = name.to_s
        file_name += '.rb' unless file_name.end_with?('.rb')
        
        # Try to find and load this template: 
        template_path = base_path.join('templates', file_name)
        file(template_path).evaluate
        
        # A successful load will register the template.
      end
      
      @templates.fetch(name.to_sym)
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
      evaluate_all unless @nodes.size > 0
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
      nodes_glob = base_path.join('nodes', '**', '*.rb')

      Dir[nodes_glob].each do |filename|
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
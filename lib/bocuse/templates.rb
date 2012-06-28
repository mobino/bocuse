module Bocuse
  
  # Remembers and stores the loaded templates.
  #
  class Templates
    
    class << self
      def templates
        @templates ||= {}
      end
    
      def get identifier
        templates[identifier] || load_template(identifier)
      end
    
      def put identifier, configuration
        templates[identifier] = configuration
      end
    
      # Loads the template if it hasn't been loaded yet.
      #
      def load_template identifier
        file = Bocuse::File.new
        configuration = file.evaluate ::File.expand_path("config/templates/#{identifier}.rb", Dir.pwd)
        put identifier, configuration
      end
    end
    
  end
  
end
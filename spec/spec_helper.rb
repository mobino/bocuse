require File.expand_path '../../lib/bocuse', __FILE__

def fixture(*args)
  Pathname.new(
    File.join(
      File.expand_path(File.dirname(__FILE__)), 
      'files',
      *args))
end
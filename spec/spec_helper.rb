require File.expand_path '../../lib/bocuse', __FILE__

def fixture(*args)
  File.join(
    File.expand_path(File.dirname(__FILE__)), 
    'files',
    *args)
end
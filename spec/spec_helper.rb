RSpec.configure do |config|
  config.mock_with :flexmock
end

def project_path(*args)
  File.join(
    File.expand_path(File.dirname(__FILE__)), 
    '..',
    *args)
end

# Returns a path below spec/files as Pathname instance for comparisons. 
#
def fixture(*args)
  Pathname.new(
    project_path('spec', 'files', *args))
end

require 'bocuse'
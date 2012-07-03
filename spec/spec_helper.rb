RSpec.configure do |config|
  config.mock_with :flexmock
end

def fixture(*args)
  Pathname.new(
    File.join(
      File.expand_path(File.dirname(__FILE__)), 
      'files',
      *args))
end

require 'bocuse'
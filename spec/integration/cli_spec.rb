require 'spec_helper'

require 'multi_json'

describe "CLI:" do
  describe 'compile NODE_FQDN' do
    it "parses nodes and outputs a single nodes JSON" do
      Dir.chdir File.expand_path('../../files/complex', __FILE__)
      
      compiled = MultiJson.load(`#{project_path('bin/bocuse')} \
        compile complex.production.example.com`)
      compiled.size.should == 3
      compiled['recipes'].should == ['nginx', 'git', 'app::install', 'app::deploy'];
      compiled['key_location'].should match(%r{spec/files/complex/config/nodes/production/key.txt$})
    end
  end
end
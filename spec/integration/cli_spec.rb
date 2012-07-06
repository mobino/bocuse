require 'spec_helper'

require 'multi_json'

describe "CLI:" do
  describe 'compile NODE_FQDN' do
    it "parses nodes and outputs a single nodes JSON" do
      Dir.chdir File.expand_path('../../files/complex', __FILE__)
      
      # Explicitly call the current binary.
      #
      
      MultiJson.load(`#{project_path('bin/bocuse')} \
        compile complex.production.example.com`).should == 
        {
          "recipes"=>["nginx", "git", "app::install", "app::deploy"], 
          "key_location" => 
            "/Users/kschiess/git/own/bocuse/spec/files/complex/config/nodes/production/key.txt"}
    end
  end
end
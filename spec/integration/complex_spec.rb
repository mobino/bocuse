# encoding: utf-8
#
require 'spec_helper'

describe 'complex example with templates' do
  let(:project) { Bocuse::Project.new(fixture('complex')) }
  
  describe 'hash of node "test.staging.example.com"' do
    it 'looks right' do
      configuration = project.evaluate('nodes/staging/complex.rb')
      
      configuration.to_h.should == {
        :user => "root",
        :users => [
          {
            :username => "some_user",
            :password => "toooootally_secret",
            :authorized_keys => ["key1", "key2"],
            :shell => "/bin/someshell",
            :gid => 1000,
            :uid => 1000,
            :sudo => true
          }
        ],
        :webserver => {
          :domains => ["staging.example.com"],
          :listen_ip => "1.2.3.4",
          :ssl_support => true
        },
        :server => {
          :ip => "11.22.33.44",
          :external_net => 28,
          :internal_ip => "1.1.1.1",
          :internal_net => "10",
          :context => 20
        },
        :cache1 => {
          :address => "1.1.1.1"
        },
        :cache2 => {
          :address => "1.1.1.1"
        },
        :empty => true,
        :recipes => ["app::install", "app::deploy"]
      }
    end
  end
  describe 'hash of node "complex.production.example.com"' do
    it "contains only recipes that are relevant to the node" do
      config = project.nodes.
        find { |name, _| name == 'complex.production.example.com' }.
        last
        
      config.to_h[:recipes].should =~ %w(nginx git app::install app::deploy my_service)
    end 
    it "configures my_service at the same time" do
      config = project.nodes.
        find { |name, _| name == 'complex.production.example.com' }.
        last
        
      config.to_h[:my_service].should == { :foo => 'bar' }
    end
  end
end
# encoding: utf-8
#
require 'spec_helper'

describe Bocuse::Loader do

  let(:loader) { described_class.new }
  
  describe 'configuration loading' do
    it 'loads the configuration' do
      Dir.chdir File.expand_path('../../files/complex', __FILE__)
      
      loader.evaluate('staging/complex').to_h.should == {
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
  
end

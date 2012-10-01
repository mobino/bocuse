# encoding: utf-8
#
require 'spec_helper'

describe 'Templates' do
  let(:project) { Bocuse::Project.new(fixture('complex')) }

  describe 'loading' do
    it 'works' do
      config = Bocuse::Configuration.new
      project.lookup_template(:users).call(config)
      
      config.to_h.should == {
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
        ]
      }
    end
  end
  
  describe '#require_ingredients' do
    it "complains if the current configuration doesn't contain the given keys" 
  end
end

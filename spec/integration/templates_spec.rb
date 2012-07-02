# encoding: utf-8
#
require 'spec_helper'

describe 'Templates' do

  describe 'loading' do
    it 'works' do
      Dir.chdir ::File.expand_path('../../files/complex', __FILE__)
      
      Bocuse::Templates.get(:users).to_h.should == {
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

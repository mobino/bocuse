# encoding: utf-8
#
require 'spec_helper'

describe 'finding nodes' do
  
  describe 'loading all nodes' do
    
    before(:each) do
      Bocuse::Nodes.clear
    end
    
    it 'works with defaults' do
      nodes = Bocuse::Nodes.all
      nodes.size.should == 1
    end
    it 'works with specific dir' do
      Dir.chdir File.expand_path('../../files/many', __FILE__)
      
      nodes = Bocuse::Nodes.all
      nodes.size.should == 4
    end
    it 'works with specific string' do
      Dir.chdir File.expand_path('../../files/many', __FILE__)
      
      nodes = Bocuse::Nodes.find 'subfolder1'
      nodes.size.should == 1
    end
    it 'works with regexp' do
      Dir.chdir File.expand_path('../../files/many', __FILE__)
      
      nodes = Bocuse::Nodes.find /1$/
      nodes.size.should == 2
      nodes['subfolder1'].should_not == nil
      nodes['subfolder2'].should == nil
      nodes['toplevel1'].should_not == nil
      nodes['toplevel2'].should == nil
    end
    
  end
  
end
# encoding: utf-8
#
require 'spec_helper'

describe 'finding nodes' do
  
  describe 'loading all nodes' do
    
    before(:each) do
      Bocuse::Nodes.clear
    end
    
    it 'works with defaults' do
      nodes = Bocuse::Nodes.all fixture('many/config')
      nodes.size.should == 4
    end
    describe 'in files/many' do
      before(:each) { 
        Dir.chdir fixture('many') }
        
      it 'works with specific dir' do
        nodes = Bocuse::Nodes.all
        nodes.size.should == 4
      end
      it 'works with specific string' do
        nodes = Bocuse::Nodes.find 'subfolder1'
        nodes.size.should == 1
      end
    end
    it "works when giving the directory as argument" do      
      nodes = Bocuse::Nodes.find 'subfolder1', fixture('many/config')
      nodes.size.should == 1
    end 
    it 'works with regexp' do
      Dir.chdir fixture('many')
      
      nodes = Bocuse::Nodes.find /1$/
      nodes.size.should == 2
      nodes['subfolder1'].should_not == nil
      nodes['subfolder2'].should == nil
      nodes['toplevel1'].should_not == nil
      nodes['toplevel2'].should == nil
    end
    
  end
  
end
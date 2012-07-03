# encoding: utf-8
#
require 'spec_helper'

describe 'finding nodes in files/many' do
  let(:project) { Bocuse::Project.new(fixture('many')) }
  
  describe 'loading all nodes' do    
    it 'works with defaults' do
      project.should have(4).nodes
    end
    it 'works with specific string' do
      nodes = project.nodes.select { |name, _| 'subfolder1' === name }
      nodes.size.should == 1
    end
  end
  
end
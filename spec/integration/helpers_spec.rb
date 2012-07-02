require 'spec_helper'

describe 'helpers example' do
  before(:each) { Bocuse::File.evaluate_all fixture('helpers/config') }
  
  describe 'loading "node"' do
    it 'works' do
      configuration = Bocuse::Nodes.find('node')
      configuration.should_not be_empty
      
      configuration['node'][:foo].should == 'bar'
    end
  end

end
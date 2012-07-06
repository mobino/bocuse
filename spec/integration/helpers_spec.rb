require 'spec_helper'

describe 'helpers example' do
  let(:project) { Bocuse::Project.new(fixture('helpers')) }
  
  describe 'loading "node"' do
    it 'works' do
      configuration = project.nodes['node']      
      configuration[:foo].should == 'bar'
      configuration[:nested][:foo].should == 'bar'
    end
  end

end
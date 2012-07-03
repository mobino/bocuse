require 'spec_helper'

require 'bocuse/project'

describe Bocuse::Project do
  describe '#base_path' do
    it "detects a simple project" do
      described_class.new(fixture('complex/config')).
        base_path.should == fixture('complex/config')
    end
    it "detects a co-hosted project" do
      described_class.new(fixture('complex')).
        base_path.should == fixture('complex/config')
    end  
  end
  describe '#unit' do
    let(:project) { described_class.new(fixture('complex')) }
    let(:unit)    { project.unit('nodes/production/complex') }
    
    it "returns a Bocuse::Unit instance" do
      unit.should be_instance_of(Bocuse::Unit)
    end 
    it "has the correct expanded path" do
      unit.path.should == 
        fixture('complex/config/nodes/production/complex')
    end 
  end
end
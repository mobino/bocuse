require 'spec_helper'

require 'bocuse/project'

describe Bocuse::Project do
  let(:project) { described_class.new(fixture('complex')) }

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
  describe '#file' do
    let(:file)    { project.file('nodes/production/complex') }
    
    it "returns a Bocuse::Unit instance" do
      file.should be_instance_of(Bocuse::File)
    end 
    it "has the correct expanded path" do
      file.path.should == 
        fixture('complex/config/nodes/production/complex')
    end 
  end
  describe '#register_node' do
    
  end
  describe '#register_template / #template' do
    before(:each) { 
      project.register_template :name, :configuration }
      
    it "returns the template" do
      project.template(:name).should == :configuration
    end 
  end
end
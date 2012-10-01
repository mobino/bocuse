require 'spec_helper'

require 'bocuse/file'

describe Bocuse::File do
  let(:context) { flexmock('context') }
  let(:project) { flexmock('project') }
  let(:file) { described_class.new('path', project, context) }
  
  before(:each) { 
    project.
      should_receive(
        :register_node, :register_template).by_default 
  }
  
  it "checks that helper inclusion only works for the current file" 

  describe 'node' do
    it 'works correctly' do
      configuration = file.node 'name' do |cfg|
        cfg.something :value
        cfg.something_else do
          key 'value'
        end
      end
      
      configuration.to_h.should == { :something => :value, :something_else => { :key => "value" } }
    end
    it "registers the node in the context" do
      project.should_receive(:register_node).
        with('name', Bocuse::Configuration).once
        
      file.node('name') { }
    end 
  end
  
  describe 'template' do
    it 'works correctly' do
      template = file.template do |cfg|
        cfg.something :value
        cfg.something_else do
          key 'value'
        end
      end
      
      config = Bocuse::Configuration.new
      template.call config
      
      config.to_h.should == { :something => :value, :something_else => { :key => "value" } }
    end
  end
  
end
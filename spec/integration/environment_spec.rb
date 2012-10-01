require 'spec_helper'

describe "bocuse environment" do
  let(:project) { Bocuse::Project.new(fixture('environment')) }
    
  it "exports node_name" do
    project.nodes['A'].to_h[:name].should == 'A'
    project.nodes['B'].to_h[:name].should == 'B'
  end
end
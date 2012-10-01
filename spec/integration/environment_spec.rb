require 'spec_helper'

describe "bocuse environment" do
  let(:project) { Bocuse::Project.new(fixture('environment')) }
    
  it "exports node_name" do
    project.nodes['A'].to_h[:name].should == 'A'
    project.nodes['B'].to_h[:name].should == 'B'
  end
  it "exports node_name to templates" do
    project.nodes['A'].to_h[:t_name].should == 'A'
    project.nodes['B'].to_h[:t_name].should == 'B'
  end 
end
require 'spec_helper'

describe "bocuse environment" do
  let(:project) { Bocuse::Project.new(fixture('cook')) }
    
  it "exports node_name" do
    expect { 
      project.nodes['node'].to_h
    }.not_to raise_error
  end
end
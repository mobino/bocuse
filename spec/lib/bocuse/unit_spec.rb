require 'spec_helper'

describe Bocuse::Unit do
  let(:context) { flexmock('context', bocuse: {node_name: 'test.of.bocuse'}) }
  let(:project) { flexmock('project') }
  def unit(configuration)
    described_class.new(Proc.new, project).
      tap { |unit| unit.call(configuration, context) }
  end
  
  describe "#bocuse environment hash" do
    it "contains the current node name" do
      configuration = {}
      unit(configuration) do |cfg|
        cfg[:node_name] = bocuse[:node_name]
      end
      
      configuration[:node_name].should == 'test.of.bocuse'
    end
  end
end
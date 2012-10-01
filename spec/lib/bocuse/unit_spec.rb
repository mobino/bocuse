require 'spec_helper'

describe Bocuse::Unit do
  let(:context) { flexmock('context', bocuse: {node_name: 'test.of.bocuse'}) }
  def unit(configuration)
    described_class.new(Proc.new, context).
      tap { |unit| unit.call(configuration) }
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
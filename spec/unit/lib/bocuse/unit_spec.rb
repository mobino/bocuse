require 'spec_helper'

require 'bocuse/unit'

describe Bocuse::Unit do

  let(:file) { described_class.new('path') }
  
  it "checks that helper inclusion only works for the current file" 

  describe 'node' do
    it 'works correctly' do
      configuration = file.node do |cfg|
        cfg.something :value
        cfg.something_else do
          key 'value'
        end
      end
      
      configuration.to_h.should == { :something => :value, :something_else => { :key => "value" } }
    end
  end
  
  describe 'template' do
    it 'works correctly' do
      configuration = file.template :identifier do |cfg|
        cfg.something :value
        cfg.something_else do
          key 'value'
        end
      end
      
      configuration.to_h.should == { :something => :value, :something_else => { :key => "value" } }
    end
  end
  
end
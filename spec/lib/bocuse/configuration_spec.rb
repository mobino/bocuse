# encoding: utf-8
#
require 'spec_helper'

describe Bocuse::Configuration do

  let(:configuration) { described_class.new }
  
  describe 'uninitialized values' do
    it 'will be ignored' do
      something = configuration.something
      
      configuration.to_h.should == {}
    end
  end
  describe 'calling a method with neither parameter nor block' do
    it 'returns the right value' do
      configuration.something.to_h.should == nil # Bocuse::Value::Empty is returned as nil
    end
    it 'returns the right value' do
      configuration.something nil # explicit nil
      
      configuration.something.to_h.should == nil
    end
    it 'returns the right value' do
      configuration.something 'value'
      
      configuration.something.to_h.should == 'value' # <= This is the tested getter.
    end
    it 'is modifiable in place' do
      something = configuration.something
      
      something << "hello"
      
      configuration.something.to_h.should == ["hello"]
    end
    it 'is modifiable in place' do
      something = configuration.something
      
      something[:key] = "value"
      
      configuration.something.to_h.should == { :key => 'value' }
    end
    it 'is modifiable in place' do
      something = configuration.something
      
      something[:key] = nil # Explicit nil.
      
      configuration.to_h.should == { :something => { :key => nil } }
    end
  end
  describe 'calling a method with a parameter, but no block' do
    it 'stores the value correctly' do
      configuration.something 'value'
      
      configuration.to_h.should == { :something => 'value' }
    end
  end
  describe 'calling a method with a block, but no parameter' do
    it 'stores the value correctly' do
      configuration.something do
        key 'value'
      end
      
      configuration.to_h.should == { :something => { :key => 'value' } }
    end
  end
  describe 'calling a method with a block, but no parameter' do
    it 'stores the value correctly' do
      configuration.something do
        key 'value'
      end
      
      configuration.to_h.should == { :something => { :key => 'value' } }
    end
  end
  describe 'configuration is accessible' do
    it 'offers a [] method' do
      configuration[:something].should == nil
    end
    it 'returns the right value' do
      configuration.something :value
      
      configuration[:something].should == :value
    end
    it 'returns the right value' do
      configuration.something do
        key 'value'
      end
      
      configuration[:something].should == { :key => 'value' }
    end
    it 'is not modifiable in place as it is a PORO' do
      something = configuration[:something]
      
      expect { something << "hello" }.to raise_error
      
      # configuration.to_h.should == { :something => ["hello"] } # This might be expected by a user.
    end
  end
end

# encoding: utf-8
#
require 'spec_helper'

describe Bocuse::Configuration do

  let(:configuration) { described_class.new }

  describe 'construction' do
    it "constructs given a hash" do
      h = { foo: 'bar' }
      
      config = described_class.new(h)
      
      config.to_h.should == h
      config.to_h.should_not equal(h)
    end 
  end
  
  describe 'uninitialized values' do
    it 'will be ignored' do
      something = configuration.something
      
      configuration.to_h.should == {}
    end
  end
  describe '.something as a value' do
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
  describe '.something "value"' do
    it 'stores the value correctly' do
      configuration.something 'value'
      
      configuration.to_h.should == { :something => 'value' }
    end
  end
  describe '.something do ... end' do
    it 'stores the value correctly' do
      configuration.something do
        key 'value'
      end
      
      configuration.to_h.should == { :something => { :key => 'value' } }
    end
  end
  describe '.something do |param| ... end' do
    it "doesn't allow implicit access" do
      expect {
        configuration.something do |something|
          foo 'bar'
        end
      }.to raise_error
    end
    it "represents a configuration, one level deeper" do
      result = nil
      configuration.something do |something|
        result = something
      end

      result.should be_instance_of(described_class)
    end   
    it 'stores the value correctly' do
      configuration.something do |cfg|
        cfg.key 'value'
      end
      
      configuration.to_h.should == { :something => { :key => 'value' } }
    end
  end
  describe '#[]' do
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
  describe '#dup' do
    before(:each) { 
      configuration.foo do
        bar []
      end }
    let(:dup) { configuration.dup }
    
    it "is performed in depth" do
      configuration[:foo][:bar].should_not equal(dup[:foo][:bar])
    end
    it "returns a duplicate" do
      configuration.to_h.should == dup.to_h
    end 
    it "takes a block, allowing modification of the result" do
      dup = configuration.dup do |cfg|
        cfg.baz 'this is new'
      end
      
      dup[:baz].should == 'this is new'
    end 
  end
end

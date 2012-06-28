# encoding: utf-8
#
require 'spec_helper'

describe Bocuse::Configuration do

  let(:configuration) { described_class.new }
  
  describe 'calling a method with neither parameter nor block' do
    it 'returns the right value' do
      configuration.something.to_h.should == nil
    end
    it 'returns the right value' do
      configuration.something 'value'
      
      configuration.something.to_h.should == 'value'
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
  end
  
end

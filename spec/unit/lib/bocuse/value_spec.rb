# encoding: utf-8
#
require 'spec_helper'

describe Bocuse::Value do

  describe 'to_h' do
    it 'works correctly' do
      Bocuse::Value.new.to_h.should == nil
    end
    it 'works correctly' do
      value = Bocuse::Value.new
      value << 1
      value.to_h.should == [1]
    end
    it 'works correctly' do
      value = Bocuse::Value.new
      value[:address] = '1.2.3.4'
      value.to_h.should == { :address => '1.2.3.4' }
    end
  end
  
end
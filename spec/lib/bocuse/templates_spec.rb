# encoding: utf-8
#
require 'spec_helper'

describe Bocuse::Templates do

  describe 'functional' do
    it 'works' do
      Bocuse::Templates.put :configuration, :some_configuration
      
      Bocuse::Templates.get(:configuration).should == :some_configuration
    end
  end

end
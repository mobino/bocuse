# encoding: utf-8
#
require 'spec_helper'

describe 'bocuse templates' do

  describe 'loading' do
    it 'works' do
      Dir.chdir ::File.expand_path('../../files/complex', __FILE__)
      
      Bocuse::Templates.get(:users).to_h.should == {
        :root => 'root'
      }
    end
  end

end

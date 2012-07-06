require 'helper'

node 'a' do |cfg|
  include_template :base
  
  helper_module Helper
  
  cfg.hostname 'a'
  cfg.helper helper
end
require 'helper1'

node 'node' do |cfg|
  helper_module Helper1
  
  helper1(cfg)
end
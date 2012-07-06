require 'helper1'

node 'node' do |cfg|
  helper_module Helper1
  
  helper1(cfg)
  
  cfg.nested do |nested|
    helper1(nested)
  end
end
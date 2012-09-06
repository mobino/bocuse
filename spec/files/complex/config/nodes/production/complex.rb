node "complex.production.example.com" do |cfg|
  # This tries to test for a regression where hash instances are confounded
  # between nodes. 
  include_template :cooking
  cook "app::install"
  cook "app::deploy"
  
  # This will cook 'my_service', but also append a key 'my_service' to the 
  # dictionary with the given content. Syntax sugar. 
  cook 'my_service' do |cfg|
    cfg.foo 'bar'
  end

  # This trips up if the evaluator of this block is in Bocuse constant lookup
  # space.
  cfg.key_location File.dirname(__FILE__) + "/key.txt"
end
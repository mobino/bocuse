node "complex.production.example.com" do |cfg|
  # This tries to test for a regression where hash instances are confounded
  # between nodes. 
  include_template :cooking
  cook "app::install"
  cook "app::deploy"

  # This trips up if the evaluator of this block is in Bocuse constant lookup
  # space.
  cfg.key_location File.dirname(__FILE__) + "/key.txt"
end
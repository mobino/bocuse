node "complex.production.example.com" do |cfg|
  # This tries to test for a regression where hash instances are confounded
  # between nodes. 
  include_template :cooking
  cook "app::install"
  cook "app::deploy"
end
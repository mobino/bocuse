node 'A' do |cfg|
  include_template :name
  cfg.name bocuse[:node_name]
end

node 'B' do |cfg|
  include_template :name
  cfg.name bocuse[:node_name]
end
# This is a test example that contains all relevant cases.
#
node "test.staging.example.com" do |cfg|
  include_template :users
  include_template 'subdirectory/empty'
  
  # Example: Webservers.
  #
  cfg.webserver do
    domains     %w(staging.example.com)
    listen_ip   "1.2.3.4"
    ssl_support true
  end
  
  # Example: Configure IP address and additional networks.
  #
  cfg.server do
    ip           "11.22.33.44"
    external_net 28
    internal_ip  "1.1.1.1"
    internal_net "10"
    context      20
  end
  
  # Example: Configuration is accessible.
  #
  cfg.cache1 do
    address cfg[:server][:internal_ip]
  end
  
  # Example: Passing in Hashes is possible
  #
  cfg.cache2 address: cfg[:server][:internal_ip]
  
  # Example: Toplevel recipes.
  #
  cook "app::install"
  cook "app::deploy"
end
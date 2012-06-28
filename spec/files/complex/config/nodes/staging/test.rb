node "test.staging.example.com" do |cfg|
  # include_template :template1
  # include_template :template2
  
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
    ip                "11.22.33.44"
    external_net      28
    internal_ip       "1.1.1.1"
    internal_net      "10"
    context           20
  end
  
  # Example: Configuration is accessible.
  #
  cfg.cache address: cfg[:server][:internal_ip]
  
  # Example: Block for later execution?
  #
  # Note: I did not see the point when we can write
  # cfg.cache do
  #   address2 cfg[:server][:internal_ip]
  # end
  #
  # cfg.cache do |cache|
  #   cache.address2 cfg[:server][:internal_ip]
  # end
  
  # Example: Toplevel recipes.
  #
  cook "app::install"
  cook "app::deploy"

end
# A shared template.
#
# Use include_template to include this one.
#
template do |cfg|
  
  cfg.user 'root'
  
  users = cfg.users
  users << {
    :username => "some_user",
    :password => "toooootally_secret",
    :authorized_keys => ['key1', 'key2'],
    :shell => "/bin/someshell",
    :gid => 1000,
    :uid => 1000,
    :sudo => true
  }
  
end
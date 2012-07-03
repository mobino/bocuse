template do |cfg|
  # This demonstrates that configurations are isolated. These two will appear
  # in the recipes section of all nodes that include this template, but only
  # once.
  cook 'nginx'
  cook 'git'
end
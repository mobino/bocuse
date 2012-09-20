Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY

  s.name = 'bocuse'
  s.version = '0.1.2.1'

  s.authors = ['Florian Hanke', 'Kaspar Schiess', 'Jens-Christian Fischer']
  s.email   = ['florian.hanke@technologyastronauts.ch', 
               'kaspar.schiess@technologyastronauts.ch', 
               'jcf@mobino.com']

  s.homepage = 'http://github.com/mobino/bocuse'

  s.summary = 'A front-end language to chef-solo.'
  s.description = <<-EOD
    bocuse teaches chef-solo a few tricks. A strict front-end to chef-solo, 
    it reads a configuration syntax that is under source control and 
    generates JSON for chef-solo.

    This library puts the full power of Ruby at your fingertips when composing
    configuration for your nodes using templates and helpers. It is the 
    missing link between puppet and chef. 
  EOD

  s.executables = ['bocuse']
  s.default_executable = 'bocuse'

  s.files = Dir['lib/**/*.rb']
  s.test_files = Dir['spec/**/*_spec.rb']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'flexmock'

  s.add_runtime_dependency 'multi_json', '>=1.0.0'
  s.add_runtime_dependency 'thor', '~> 0.15'
  s.add_runtime_dependency 'blankslate', '3.1.2'
end

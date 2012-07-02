Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY

  s.name = 'bocuse'
  s.version = '0.0.1'

  s.author = 'Mobino AG'
  s.email = ''

  s.homepage = 'http://github.com/mobino/bocuse'
  s.rubyforge_project = ''

  s.description = 'A front-end language to chef-solo.'
  s.summary = 'A front-end language to chef-solo.'

  s.executables = ['bocuse']
  s.default_executable = 'bocuse'

  s.files = Dir['lib/**/*.rb']
  s.test_files = Dir['spec/**/*_spec.rb']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'

  s.add_runtime_dependency 'multi_json', '>=1.0.0'
  s.add_runtime_dependency 'thor', '~> 0.15'
end

MRuby::Gem::Specification.new('mruby-httprequest') do |spec|
  spec.license = 'MIT'
  spec.authors = 'MATSUMOTO Ryosuke'
  spec.version = '0.0.1'
  spec.add_dependency('mruby-simplehttp')
  spec.add_dependency('mruby-http')
end

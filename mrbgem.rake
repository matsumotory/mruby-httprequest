MRuby::Gem::Specification.new('mruby-httprequest') do |spec|
  spec.license = 'MIT'
  spec.authors = 'MATSUMOTO Ryosuke'
  spec.add_dependency('mruby-simplehttp')
  spec.add_dependency('mruby-http')
end

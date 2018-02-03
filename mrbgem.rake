MRuby::Gem::Specification.new('mruby-httprequest') do |spec|
  spec.license = 'MIT'
  spec.authors = 'MATSUMOTO Ryosuke'
  spec.version = '0.0.1'
  spec.add_dependency('mruby-simplehttp')
  spec.add_dependency('mruby-http')
  # remove dependency for now until merging https://github.com/luisbebop/mruby-polarssl/pull/12
  #spec.add_dependency('mruby-polarssl')
end

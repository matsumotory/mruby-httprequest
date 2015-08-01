# HttpRequest Class for mruby
refactored HttpRequest using mruby-simplehttp and mruby-http

original code is iij/mruby

## install by mrbgems
 - add conf.gem line to `build_config.rb`
```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :mgem => 'mruby-httprequest'
end
```

## example

```ruby
class GrowthForecast
  DEFAULTADDRESS  = "127.0.0.1"
  DEFAULTPORT     = 5125
  class Client
    def initialize(address, port)
      address = DEFAULTADDRESS if address.nil?
      port   = DEFAULTPORT if address.nil?
      @url = sprintf("http://%s:%s/api", address, port.to_s)
    end

    def post(config, data)
      http = HttpRequest.new()
      api_url = sprintf("%s/%s/%s/%s", @url, config[:service], config[:section], config[:gragh])
      http.post(api_url, {
        :number => data[:number],
        :color  => data[:color],
        :mode   => data[:mode],
      },{
        'User-Agent' => "mruby-growthforecast",
      })
    end
  end
end
```

# License
under the MIT License:

* http://www.opensource.org/licenses/mit-license.php


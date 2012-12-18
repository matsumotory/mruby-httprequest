# HttpRequest Class for mruby
refactored HttpRequest using mruby-uv and mruby-http

original code is iij/mruby

## install by mrbgems
```bash
git clone git://github.com/matsumoto-r/mruby-httprequest.git
cp -pr mruby-httprequest ${MRUBY_ROOT}/mrbgems/g/.
echo mruby-httprequest >> ${MRUBY_ROOT}/mrbgems/GEMS.active
cd ${MRUBY_ROOT}
make
./bin/mruby ${MRUBY_ROOT}/mrbgems/g/mruby-httprequest/example/hogehoge.rb
```

## example

```ruby
class GrowthForecast
  DEFAULTADDRESS  = "127.0.0.1"
  DEFAULTPORT     = 5125
  class Client
    def initialize(address, port)
      adress = DEFAULTADDRESS if adress.nil?
      port   = DEFAULTAPORT if adress.nil?
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


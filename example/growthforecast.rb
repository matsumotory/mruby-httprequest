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

g = GrowthForecast::Client.new("127.0.0.1", 5125)

config = {
  :service  => "apache",
  :section  => "scoreboard",
  :gragh    => "woreker",
}

data = {
  :number   => 7,
  :color    => "#333399",
  :mode     => "count",
}

p g.post(config, data)

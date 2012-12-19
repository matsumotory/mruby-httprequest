class HttpRequest

  def get(url, body = nil, headers = {})
    request("GET", url, body, headers)
  end

  def head(url, headers = {})
    request("HEAD", url, nil, headers)
  end

  def post(url, body = nil, headers = {})
    request("POST", url, body, headers)
  end

  def put(url, body = nil, headers = {})
    request("PUT", url, body, headers)
  end

  def delete(url, headers = {})
    request("DELETE", url, nil, headers)
  end

  def request(method, url, body, headers)
    parser = HTTP::Parser.new()
    url = parser.parse_url(url)
    request = create_http_request(method, body, headers)
    host = url.host.to_sym.to_s
    if url.query
        request_uri = url.path + "?" + url.query
    else
        request_uri = url.path
    end
    SimpleHttp.new(host, url.port).request(method, request_uri, request)
  end

  def encode_parameters(params, delimiter = '&', quote = nil)
    if params.is_a?(Hash)
      params = params.map do |key, value|
        sprintf("%s=%s%s%s", key, quote, value, quote)
      end
    else
      params = params.map { |value| escape(value) }
    end
    delimiter ? params.join(delimiter) : params
  end

  def create_http_request(method, body, headers)
    method = method.upcase.to_s
    request = {}
    request = headers
    if method == "POST" || method == "PUT" || method == "GET"
      request["body"] = body.is_a?(Hash) ? encode_parameters(body) : body.to_s
      unless request["Content-Type"]
        request["Content-Type"] = 'application/x-www-form-urlencoded'
      end
      request["Content-Length"] = (request["body"] || '').length
    end
    request
  end
end

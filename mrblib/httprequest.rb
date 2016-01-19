class HttpRequest

  def get(url, body = nil, headers = {}, &b)
    request("GET", url, body, headers, &b)
  end

  def head(url, headers = {}, &b)
    request("HEAD", url, nil, headers, &b)
  end

  def post(url, body = nil, headers = {}, &b)
    request("POST", url, body, headers, &b)
  end

  def put(url, body = nil, headers = {}, &b)
    request("PUT", url, body, headers, &b)
  end

  def delete(url, headers = {}, &b)
    request("DELETE", url, nil, headers, &b)
  end

  def request(method, url, body, headers, &b)
    parser = HTTP::Parser.new()
    url = parser.parse_url(url)
    request = create_http_request(method, body, headers)
    host = url.host.to_sym.to_s
    if url.query
        request_uri = url.path + "?" + url.query
    else
        request_uri = url.path
    end
    SimpleHttp.new(url.schema, host, url.port).request(method, request_uri, request, &b)
  end

  def encode_parameters(params, delimiter = '&', quote = nil)
    if params.is_a?(Hash)
      params = params.map do |key, value|
        sprintf("%s=%s%s%s", escape(key), quote, escape(value), quote)
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
      #if request["Content-Type"]
      #  request["Content-Type"] = 'application/x-www-form-urlencoded'
      #end
      if body
        request["body"] = body.is_a?(Hash) ? encode_parameters(body) : body.to_s
        request["Content-Length"] = (request["body"] || '').length
      end
    end
    request
  end
  #def escape(str, unsafe = nil)
  def escape(str)
    reserved_str = [
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "n", "m", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "-", ".", "_", "~"
    ]
    tmp = ''
    str = str.to_s
    str.size.times do |idx|
      chr = str[idx]
      if reserved_str.include?(chr)
        tmp += chr
      else
        tmp += "%" + chr.unpack("H*").first.upcase
      end
    end
    #puts "#{str}: #{tmp}"
    tmp
  end
end

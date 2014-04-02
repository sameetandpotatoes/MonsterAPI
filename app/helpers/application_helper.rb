module ApplicationHelper
  def getrequest(url)
    result = Net::HTTP.get(URI.parse(url))
    result = JSON.parse(result);
  end
  def postrequest(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
    request = Net::HTTP::Post.new(uri.request_uri)
    response = http.request(request)
    response = JSON.parse(response.body())
  end
end

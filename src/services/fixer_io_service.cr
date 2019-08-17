class FixerIoService
  BASE_URL = "data.fixer.io"
  API_KEY = ENV.fetch("FIXER_IO_KEY")

  property client

  def initialize
    @headers = HTTP::Headers{"Content-Type" => "application/javascript", "Accept" => "application/javascript"}
    @client = HTTP::Client.new(BASE_URL)
  end


  def latest
    @client.get(uri("latest"), headers: headers)
  end

  def currencies
    @client.get(uri("symbols"), headers: headers)
  end

  private def params(options = NamedTuple.new) : String
    defaults = {access_key: API_KEY}
    opts = defaults.merge(options)
    HTTP::Params.encode(opts)
  end

  private def uri(path, options = NamedTuple.new)
    "/api/#{path}?" + params(options)
  end

  private def headers(options = {} of String => String)
    hdrs = @headers
    options.each do |k,v|
      hdrs.add(k,v)
    end
    hdrs
  end
end

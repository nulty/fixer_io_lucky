class FixerIoService
  BASE_URL = "data.fixer.io"
  API_KEY = ENV.fetch("FIXER_IO_KEY")

  property client

  def initialize
    @client = HTTP::Client.new(BASE_URL)
  end


  def latest
    params = HTTP::Params.encode({"access_key" => API_KEY})
    @client.get(uri("latest"))
  end

  def currencies
    @client.get(uri("symbols"))
  end

  private def params(options = NamedTuple.new) : String
    defaults = {access_key: API_KEY}
    opts = defaults.merge(options)
    HTTP::Params.encode(opts)
  end

  private def uri(path, options = NamedTuple.new)
    "/api/#{path}?" + params(options)
  end
end


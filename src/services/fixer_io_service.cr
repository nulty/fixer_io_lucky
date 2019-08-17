class FixerIoService
  BASE_URL = "data.fixer.io"
  API_KEY = ENV.fetch("FIXER_IO_KEY")

  property client

  def initialize
    @client = HTTP::Client.new(BASE_URL)
  end


  def latest
    params = HTTP::Params.encode({"access_key" => API_KEY})
    uri = "/api/latest?" + params
    @client.get(uri)
  end
end


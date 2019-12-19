require "./spec_helper"

describe FixerIoService do

  it "has the base uri for the api" do
    FixerIoService::BASE_URL.should eq "data.fixer.io"
  end

  it "has a request client" do
    fixer = FixerIoService.new
    fixer.client.should be_a HTTP::Client
  end

  it "#latest calls the fixer.io API historical" do
    fixture = File.read("#{__DIR__}/fixtures/fixer_latest.json")

    WebMock.stub(:get, "http://data.fixer.io/api/latest?access_key=asdf&base=EUR")
      .to_return(body: fixture, headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.latest

    parsed_response = RatesResponse.from_json(response.body)
    parsed_response.success.should be_true
    parsed_response.base.should eq "EUR"
    if rates = parsed_response.rates
      rates["CAD"].should eq 1.472846
    end

    response.success?.should be_true
  end

  it "#latest calls the fixer.io API historical" do
    fixture = File.read("#{__DIR__}/fixtures/fixer_latest.json")

    WebMock.stub(:get, "http://data.fixer.io/api/2013-10-01?access_key=asdf&base=EUR")
      .to_return(body: fixture, headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.historical("2013-10-01")

    parsed_response = RatesResponse.from_json(response.body)
    parsed_response.success.should be_true
    parsed_response.base.should eq "EUR"
    if rates = parsed_response.rates
      rates["CAD"].should eq 1.472846
    end

    response.success?.should be_true
  end

  it "#currencies calls the fixer.io API symbols" do
    fixture = File.read("#{__DIR__}/fixtures/fixer_symbols.json")

    WebMock.stub(:get, "http://data.fixer.io/api/symbols?access_key=asdf")
      .to_return(body: fixture, headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.currencies

    parsed_response = CurrenciesResponse.from_json(response.body)
    parsed_response.success.should be_true
    parsed_response.symbols["AED"].should eq "United Arab Emirates Dirham"

    response.success?.should be_true
  end

  it "#currencies calls the fixer.io API historical with error" do
    fixture = File.read("#{__DIR__}/fixtures/fixer_latest_error.json")

    WebMock.stub(:get, "http://data.fixer.io/api/13-12-2019?access_key=asdf&base=EUR")
      .to_return(body: fixture, headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.historical("13-12-2019", "EUR")

    parsed_response = RatesResponse.from_json(response.body)
    parsed_response.success.should be_false

    if error = parsed_response.error
      error.code.should eq 105
      error.type.should eq "base_currency_access_restricted"
    end
  end
end

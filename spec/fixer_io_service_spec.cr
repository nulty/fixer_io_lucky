require "./spec_helper"

describe FixerIoService do

  it "has the base uri for the api" do
    FixerIoService::BASE_URL.should eq "data.fixer.io"
  end

  it "has a request client" do
    fixer = FixerIoService.new
    fixer.client.should be_a HTTP::Client
  end

  it "#latest calls the fixer.io API latest" do
    fixture = File.read("#{__DIR__}/fixtures/fixer_latest.json")

    WebMock.stub(:get, "http://data.fixer.io/api/latest?access_key=asdf").to_return(body: fixture, headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.latest

    parsed_response = JSON.parse(response.body)
    parsed_response["success"].should be_true
    parsed_response["base"].should eq "EUR"
    parsed_response.dig("rates", "CAD").should eq 1.472846

    response.success?.should be_true
  end

 it "#currencies calls the fixer.io API symbols" do
    fixture = File.read("#{__DIR__}/fixtures/fixer_symbols.json")

    WebMock.stub(:get, "http://data.fixer.io/api/symbols?access_key=asdf").to_return(body: fixture, headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.currencies

    parsed_response = JSON.parse(response.body)
    parsed_response["success"].should be_true
    parsed_response.dig("symbols", "AED").should eq "United Arab Emirates Dirham"

    response.success?.should be_true
  end
end

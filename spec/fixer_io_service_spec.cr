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
    WebMock.stub(:get, "http://data.fixer.io/api/latest?access_key=asdf").to_return(body: "Hi", headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.latest
    response.body.should eq "Hi"
    response.success?.should be_true
  end

  it "#currencies calls the fixer.io API symbols" do
    WebMock.stub(:get, "http://data.fixer.io/api/symbols?access_key=asdf").to_return(body: "Hi", headers: {"Host" => "data.fixer.io"}, status: 200)

    response = FixerIoService.new.currencies
    response.body.should eq "Hi"
    response.success?.should be_true
  end
end

require "./spec_helper"

describe FixerIoService do

  it "has the base uri for the api" do
    FixerIoService::BASE_URL.should eq "data.fixer.io"
  end

  it "loads the api key" do
    FixerIoService::API_KEY.starts_with?("3").should be_true
  end

  it "has a request client" do
    fixer = FixerIoService.new
    fixer.client.should be_a HTTP::Client
  end

  # Enable only when we want to test the API
  #it "latest" do
    #fixer = FixerIoService.new
    #fixer.latest.status.success?.should be_true
  #end
end

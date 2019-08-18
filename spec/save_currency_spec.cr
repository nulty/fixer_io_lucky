require "./spec_helper"

describe SaveCurrency do

  it "creates the currencies if currency not exists" do
    json = {"success" => true, "symbols" => {"AUD" => "Australian Dollar", "GBP" => "British Pound"}}.to_json
    currency_response = CurrenciesResponse.from_json(json)
    SaveCurrency.import(currency_response)

    CurrencyQuery.new.select_count.should eq 2
    CurrencyQuery.first.code.should eq "AUD"
    CurrencyQuery.first.name.should eq "Australian Dollar"
  end

  it "updates the currencies if currency exists" do
    json = {"success" => true, "symbols" => {"AUD" => "Australian Dollar", "GBP" => "British Pound"}}.to_json
    currency_response = CurrenciesResponse.from_json(json)
    SaveCurrency.import(currency_response)

    CurrencyQuery.first.name.should eq "Australian Dollar"

    update_json = {"success" => true, "symbols" => {"AUD" => "Australian Pound", "GBP" => "British Pound"}}.to_json
    currency_response = CurrenciesResponse.from_json(update_json)
    SaveCurrency.import(currency_response)

    CurrencyQuery.first.name.should eq "Australian Pound"
  end
end


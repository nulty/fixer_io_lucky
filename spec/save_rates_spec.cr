require "./spec_helper"

describe SaveRate do

  it "creates a rate for the day" do
    SaveCurrency.create!(name: "Australian Dollar", code: "AUD")
    SaveCurrency.create!(name: "Euro", code: "EUR")

    json = {
      "success": true,
      "timestamp": 1566069966,
      "base": "EUR",
      "date": "2019-08-17",
      "rates": {
        "AUD": 4.075112
      }
    }.to_json
    rate_response = RatesResponse.from_json(json)

    SaveRate.import(rate_response)

    RateQuery.new.select_count.should eq 1
    rate = RateQuery.new.preload_base_currency.preload_conversion_currency.first
    rate.base_currency.code.should eq "EUR"
    rate.conversion_currency.code.should eq "AUD"
  end

  it "creates doesnt create a rate for the day if one exists" do
    cc = SaveCurrency.create!(name: "Australian Dollar", code: "AUD")
    bc = SaveCurrency.create!(name: "Euro", code: "EUR")
    rate_val = 4.075112

    date = Time.parse_utc("2019-08-17", "%F")
    SaveRate.create!(
      conversion_currency_id: cc.id,
      base_currency_id: bc.id,
      rate: rate_val,
      date: date)

    RateQuery.new.select_count.should eq 1

    json = {
      "success": true,
      "timestamp": 1566069966,
      "base": "EUR",
      "date": "2019-08-17",
      "rates": {
        "AUD": 4.075112
      }
    }.to_json

    rate_response = RatesResponse.from_json(json)

    SaveRate.import(rate_response)

    RateQuery.new.select_count.should eq 1
  end
end


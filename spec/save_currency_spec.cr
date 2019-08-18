require "./spec_helper"

describe SaveCurrency do

  it "creates the currencies if currency not exists" do
    subject = {"AUD" => "Australian Dollar", "GBP" => "British Pound"}
    SaveCurrency.import(subject)

    CurrencyQuery.new.select_count.should eq 2
    CurrencyQuery.first.code.should eq "AUD"
    CurrencyQuery.first.name.should eq "Australian Dollar"
  end

  it "updates the currencies if currency exists" do
    subject = {"AUD" => "Australian Dollar"}
    SaveCurrency.import(subject)

    CurrencyQuery.first.name.should eq "Australian Dollar"

    subject = {"AUD" => "Australian Pound"}
    SaveCurrency.import(subject)
    CurrencyQuery.first.name.should eq "Australian Pound"
  end
end


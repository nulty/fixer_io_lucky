class Home::Index < BrowserAction
  get "/" do

    base_currencies = CurrencyQuery.new
                        .id.in(RateQuery.all
                                        .distinct_on(&.base_currency_id)
                                        .base_currency_id.rows.map(&.base_currency_id)
                              )
    conversion_currencies = CurrencyQuery.new.join_conversion_rates

    rates = RateQuery.new.preload_base_currency.preload_conversion_currency
    render Dashboard::ShowPage, base_currencies: base_currencies, conversion_currencies: conversion_currencies, rates: rates
  end
end

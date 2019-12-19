class SaveRate < Rate::SaveOperation
  def self.import(response : RatesResponse)
    # creates a new rate for each date. If rate exists for the base curr and target curre
    # then no new rate is created

    if base_code = response.base

      base_currency = CurrencyQuery.new.code(base_code).first
      raise ArgumentError.new if !base_currency
      if (date = response.date) && (rates = response.rates)
        rates.each do |code, rate_val|
          conversion_currency = CurrencyQuery.new.code(code).first

          rate = RateQuery.new.base_currency_id(base_currency.id).conversion_currency_id(conversion_currency.id).date(date).first?
          if !rate
            SaveRate.create!(
              conversion_currency_id: conversion_currency.id,
              base_currency_id: base_currency.id,
              rate: rate_val,
              date: date)
          end
        end
      end
    end
  end
end

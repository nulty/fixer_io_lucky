require "json"

class CurrenciesResponse
  JSON.mapping(
    success: Bool,
    symbols: Hash(String, String)
    #symbols: CurrencyJson
  )
end

class ErrorJson
  JSON.mapping(
    code: Int64,
    type: String
  )
end

class RatesResponse
  JSON.mapping(
    success: Bool,
    base: String?,
    timestamp: Int64?,
    date: { type: Time, converter: Time::Format.new("%F"), nilable: true },
    rates: Hash(String, Float64)?,
    error: ErrorJson?
  )
end

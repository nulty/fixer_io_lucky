class Api::Rates::Show < ApiAction
  param base_currency : String
  param conversion_currency : String
  post "/rates" do

    base_currency = params.get(:"base-currency").to_s
    conversion_currency = params.get(:"conversion-currency").to_s
    rate = RateQuery.new.base_currency_id(base_currency)
                        .conversion_currency_id(conversion_currency)
                        .created_at.asc_order
                        .first.rate


    json({data: rate.to_s})
  end
end

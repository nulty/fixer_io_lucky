class Currency < BaseModel
  table :currencies do
    has_many conversion_rates : Rate, foreign_key: :conversion_currency_id
    has_many base_rates : Rate, foreign_key: :base_currency_id

    column code : String
    column name : String
  end
end

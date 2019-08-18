class Rate < BaseModel
  table :rates do
    belongs_to conversion_currency : Currency
    belongs_to base_currency : Currency

    column rate : Float64
    column date : Time
  end
end

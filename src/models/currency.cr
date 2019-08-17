class Currency < BaseModel
  table :currencies do
    column code : String
    column name : String
  end
end

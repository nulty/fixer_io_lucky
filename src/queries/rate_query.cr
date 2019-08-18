class RateQuery < Rate::BaseQuery

  #def join_base_currencies
    #join(Avram::Join::Inner.new(:rates, :currencies, :base_currencies_id, :id))
  #end

  #def join_conversion_currencies
    #join(Avram::Join::Inner.new(:rates, :currencies, :conversion_currencies_id, :id))
  #end
end

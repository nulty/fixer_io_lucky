class CurrencyQuery < Currency::BaseQuery
  def join_base_rates
    join(Avram::Join::Inner.new(:currencies, :rates, :id, :base_currency_id))
  end

  def join_conversion_rates
    join(Avram::Join::Inner.new(:currencies, :rates, :id, :conversion_currency_id))
  end
end
